contract Wallet is ENSResolvable, Vault, GasTopUpLimit, LoadLimit {

    event ToppedUpGas(address _sender, address _owner, uint _amount);
    event LoadedTokenCard(address _asset, uint _amount);
    event ExecutedTransaction(address _destination, uint _value, bytes _data);

    uint constant private _DEFAULT_MAX_STABLECOIN_LOAD_LIMIT = 10000; //10,000 USD

    /// @dev Is the registered ENS node identifying the licence contract.
    bytes32 private _licenceNode;

    /// @dev these are needed to allow for the executeTransaction method
    uint32 private constant _TRANSFER= 0xa9059cbb;
    uint32 private constant _APPROVE = 0x095ea7b3;

    /// @dev Constructor initializes the wallet top up limit and the vault contract.
    /// @param _owner_ is the owner account of the wallet contract.
    /// @param _transferable_ indicates whether the contract ownership can be transferred.
    /// @param _ens_ is the address of the ENS registry.
    /// @param _tokenWhitelistNameHash_ is the ENS name hash of the Token whitelist.
    /// @param _controllerNameHash_ is the ENS name hash of the Controller contract.
    /// @param _licenceNameHash_ is the ENS name hash of the Licence contract.
    /// @param _spendLimit_ is the initial spend limit.
    constructor(address _owner_, bool _transferable_, address _ens_, bytes32 _tokenWhitelistNameHash_, bytes32 _controllerNameHash_, bytes32 _licenceNameHash_, uint _spendLimit_) ENSResolvable(_ens_) Vault(_owner_, _transferable_, _tokenWhitelistNameHash_, _controllerNameHash_, _spendLimit_) public {
        // Get the stablecoin's magnitude.
        ( ,uint256 stablecoinMagnitude, , , , , ) = _getStablecoinInfo();
        require(stablecoinMagnitude > 0, "stablecoin not set");
        _initializeLoadLimit(_DEFAULT_MAX_STABLECOIN_LOAD_LIMIT * stablecoinMagnitude);
        _licenceNode = _licenceNameHash_;
    }

    /// @dev Refill owner's gas balance, revert if the transaction amount is too large
    /// @param _amount is the amount of ether to transfer to the owner account in wei.
    function topUpGas(uint _amount) external isNotZero(_amount) onlyOwnerOrController {
        // Check against the daily spent limit and update accordingly, require that the value is under remaining limit.
        _enforceLimit(_gasTopUpLimit, _amount);
        // Then perform the transfer
        owner().transfer(_amount);
        // Emit the gas top up event.
        emit ToppedUpGas(msg.sender, owner(), _amount);
    }

    /// @dev Load a token card with the specified asset amount.
    /// @dev the amount send should be inclusive of the percent licence.
    /// @param _asset is the address of an ERC20 token or 0x0 for ether.
    /// @param _amount is the amount of assets to be transferred in base units.
    function loadTokenCard(address _asset, uint _amount) external payable onlyOwner {
        //check if token is allowed to be used for loading the card
        require(_isTokenLoadable(_asset), "token not loadable");
        // Convert token amount to stablecoin value.
        uint stablecoinValue = convertToStablecoin(_asset, _amount);
        // Check against the daily spent limit and update accordingly, require that the value is under remaining limit.
        _enforceLimit(_loadLimit, stablecoinValue);
        // Get the TKN licenceAddress from ENS
        address licenceAddress = _ensResolve(_licenceNode);
        if (_asset != address(0)) {
            require(ERC20(_asset).approve(licenceAddress, _amount), "ERC20 token approval was unsuccessful");
            ILicence(licenceAddress).load(_asset, _amount);
        } else {
            ILicence(licenceAddress).load.value(_amount)(_asset, _amount);
        }

        emit LoadedTokenCard(_asset, _amount);

    }

    /// @dev This function allows for the owner to send transaction from the Wallet to arbitrary addresses
    /// @param _destination address of the transaction
    /// @param _value ETH amount in wei
    /// @param _data transaction payload binary
    function executeTransaction(address _destination, uint _value, bytes _data) external onlyOwner {
        // Check if there exists at least a method signature in the transaction payload
        if (_data.length >= 4) {
            // Get method signature
            uint32 signature = _bytesToUint32(_data, 0);

            // Check if method is either ERC20 transfer or approve
            if (signature == _TRANSFER || signature == _APPROVE) {
                require(_data.length >= 4 + 32 + 32, "invalid transfer / approve transaction data");
                uint amount = _sliceUint(_data, 4 + 32);
                // The "toOrSpender" is the '_to' address for a ERC20 transfer or the '_spender; in ERC20 approve
                // + 12 because address 20 bytes and this is padded to 32
                address toOrSpender = _bytesToAddress(_data, 4 + 12);

                // Check if the toOrSpender is in the whitelist
                if (!whitelistMap[toOrSpender]) {
                    // If the address (of the token contract, e.g) is not in the TokenWhitelist used by
                    // the convert method, then etherValue will be zero
                    uint etherValue = convertToEther(_destination, amount);
                    _enforceLimit(_spendLimit, etherValue);
                }
            }
        }

        // If value is send across as a part of this executeTransaction, this will be sent to any payable
        // destination. As a result enforceLimit if destination is not whitelisted.
        if (!whitelistMap[_destination]) {
            _enforceLimit(_spendLimit, _value);
        }

        require(_externalCall(_destination, _value, _data.length, _data), "executing transaction failed");

        emit ExecutedTransaction(_destination, _value, _data);
    }

    /// @return licence contract node registered in ENS.
    function licenceNode() external view returns (bytes32) {
        return _licenceNode;
    }

    /// @dev Convert ether or ERC20 token amount to the corresponding stablecoin amount.
    /// @param _token ERC20 token contract address.
    /// @param _amount amount of token in base units.
    function convertToStablecoin(address _token, uint _amount) public view returns (uint) {
        //avoid the unnecessary calculations if the token to be loaded is the stablecoin itself
        if (_token == _stablecoin()) {
            return _amount;
        }
        //0x0 represents ether
        if (_token != address(0)) {
            //convert to eth first, same as convertToEther()
            // Store the token in memory to save map entry lookup gas.
            (,uint256 magnitude, uint256 rate, bool available, , , ) = _getTokenInfo(_token);
            // require that token both exists in the whitelist and its rate is not zero.
            require(available, "token is not available");
            require(<FILL_ME>)
            // Safely convert the token amount to ether based on the exchange rate.
            _amount = _amount.mul(rate).div(magnitude);
        }
        //_amount now is in ether
        // Get the stablecoin's magnitude and its current rate.
        ( ,uint256 stablecoinMagnitude, uint256 stablecoinRate, bool stablecoinAvailable, , , ) = _getStablecoinInfo();
            // Check if the stablecoin rate is set.
        require(stablecoinAvailable, "token is not available");
        require(stablecoinRate != 0, "stablecoin rate is 0");
        // Safely convert the token amount to stablecoin based on its exchange rate and the stablecoin exchange rate.
        // SWC-Integer Overflow and Underflow: L707
        return _amount.mul(stablecoinMagnitude).div(stablecoinRate);
    }

    /// @dev This function is taken from the Gnosis MultisigWallet: https://github.com/gnosis/MultiSigWallet/
    /// @dev License: https://github.com/gnosis/MultiSigWallet/blob/master/LICENSE
    /// @dev thanks :)
    /// @dev This calls proxies arbitrary transactions to addresses
    /// @param _destination address of the transaction
    /// @param _value ETH amount in wei
    /// @param _dataLength length of the transaction data
    /// @param _data transaction payload binary
    // call has been separated into its own function in order to take advantage
    // of the Solidity's code generator to produce a loop that copies tx.data into memory.
    function _externalCall(address _destination, uint _value, uint _dataLength, bytes _data) private returns (bool) {
        bool result;
        assembly {
            let x := mload(0x40)   // "Allocate" memory for output (0x40 is where "free memory" pointer is stored by convention)
            let d := add(_data, 32) // First 32 bytes are the padded length of data, so exclude that
            result := call(
                sub(gas, 34710),   // 34710 is the value that solidity is currently emitting
                                   // It includes callGas (700) + callVeryLow (3, to pay for SUB) + callValueTransferGas (9000) +
                                   // callNewAccountGas (25000, in case the destination address does not exist and needs creating)
                _destination,
                _value,
                d,
                _dataLength,        // Size of the input (in bytes) - this is what fixes the padding problem
                x,
                0                  // Output is ignored, therefore the output size is zero
            )
        }

        return result;
    }

    /// @dev This function converts to an address
    /// @param _bts bytes
    /// @param _from start position
    function _bytesToAddress(bytes _bts, uint _from) private pure returns (address) {
        require(_bts.length >= _from + 20, "slicing out of range");

        uint160 m = 0;
        uint160 b = 0;

        for (uint8 i = 0; i < 20; i++) {
            m *= 256;
            b = uint160 (_bts[_from + i]);
            m += (b);
        }

        return address(m);
    }

    /// @dev This function slicing bytes into uint32
    /// @param _bts some bytes
    /// @param _from  a start position
    function _bytesToUint32(bytes _bts, uint _from) private pure returns (uint32) {
        require(_bts.length >= _from + 4, "slicing out of range");

        uint32 m = 0;
        uint32 b = 0;

        for (uint8 i = 0; i < 4; i++) {
            m *= 256;
            b = uint32 (_bts[_from + i]);
            m += (b);
        }

        return m;
    }

    /// @dev This function slices a uint
    /// @param _bts some bytes
    /// @param _from  a start position
    // credit to https://ethereum.stackexchange.com/questions/51229/how-to-convert-bytes-to-uint-in-solidity
    // and Nick Johnson https://ethereum.stackexchange.com/questions/4170/how-to-convert-a-uint-to-bytes-in-solidity/4177#4177
    function _sliceUint(bytes _bts, uint _from) private pure returns (uint) {
        require(_bts.length >= _from + 32, "slicing out of range");

        uint x;
        assembly {
            x := mload(add(_bts, add(0x20, _from)))
        }

        return x;
    }

}