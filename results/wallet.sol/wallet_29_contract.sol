contract Vault is AddressWhitelist, SpendLimit, ERC165, TokenWhitelistable {

    using SafeMath for uint256;

    event Received(address _from, uint _amount);
    event Transferred(address _to, address _asset, uint _amount);

    /// @dev Supported ERC165 interface ID.
    bytes4 private constant _ERC165_INTERFACE_ID = 0x01ffc9a7; // solium-disable-line uppercase

    /// @dev Constructor initializes the vault with an owner address and spend limit. It also sets up the controllable and tokenWhitelist contracts with the right name registered in ENS.
    /// @param _owner_ is the owner account of the wallet contract.
    /// @param _transferable_ indicates whether the contract ownership can be transferred.
    /// @param _tokenWhitelistNameHash_ is the ENS name hash of the Token whitelist.
    /// @param _controllerNameHash_ is the ENS name hash of the controller.
    /// @param _spendLimit_ is the initial spend limit.
    constructor(address _owner_, bool _transferable_, bytes32 _tokenWhitelistNameHash_, bytes32 _controllerNameHash_, uint _spendLimit_) SpendLimit(_spendLimit_) Ownable(_owner_, _transferable_) Controllable(_controllerNameHash_) TokenWhitelistable(_tokenWhitelistNameHash_) public {}

    /// @dev Checks if the value is not zero.
    modifier isNotZero(uint _value) {
        require(_value != 0, "provided value cannot be zero");
        _;
    }

    /// @dev Ether can be deposited from any source, so this contract must be payable by anyone.
    function() external payable {
        require(msg.data.length == 0, "msg data needs to be empty");
        emit Received(msg.sender, msg.value);
    }

    /// @dev Returns the amount of an asset owned by the contract.
    /// @param _asset address of an ERC20 token or 0x0 for ether.
    /// @return balance associated with the wallet address in wei.
    function balance(address _asset) external view returns (uint) {
        if (_asset != address(0)) {
            return ERC20(_asset).balanceOf(this);
        } else {
            return address(this).balance;
        }
    }

    /// @dev Transfers the specified asset to the recipient's address.
    /// @param _to is the recipient's address.
    /// @param _asset is the address of an ERC20 token or 0x0 for ether.
    /// @param _amount is the amount of assets to be transferred in base units.
    function transfer(address _to, address _asset, uint _amount) external onlyOwner isNotZero(_amount) {
        // Checks if the _to address is not the zero-address
        require(_to != address(0), "_to address cannot be set to 0x0");

        // If address is not whitelisted, take daily limit into account.
        if (!whitelistMap[_to]) {
            //initialize ether value in case the asset is ETH
            uint etherValue = _amount;
            // Convert token amount to ether value if asset is an ERC20 token.
            if (_asset != address(0)) {
                etherValue = convertToEther(_asset, _amount);
            }
            // Check against the daily spent limit and update accordingly
            // Check against the daily spent limit and update accordingly, require that the value is under remaining limit.
            _enforceLimit(_spendLimit, etherValue);
        }
        // Transfer token or ether based on the provided address.
        if (_asset != address(0)) {
            require(ERC20(_asset).transfer(_to, _amount), "ERC20 token transfer was unsuccessful");
        } else {
            _to.transfer(_amount);
        }
        // Emit the transfer event.
        emit Transferred(_to, _asset, _amount);
    }

    /// @dev Checks for interface support based on ERC165.
    function supportsInterface(bytes4 interfaceID) external view returns (bool) {
        return interfaceID == _ERC165_INTERFACE_ID;
    }

    /// @dev Convert ERC20 token amount to the corresponding ether amount.
    /// @param _token ERC20 token contract address.
    /// @param _amount amount of token in base units.
    function convertToEther(address _token, uint _amount) public view returns (uint) {
        // Store the token in memory to save map entry lookup gas.
        (,uint256 magnitude, uint256 rate, bool available, , , ) = _getTokenInfo(_token);
        // If the token exists require that its rate is not zero.
        if (available) {
            require(<FILL_ME>)
            // Safely convert the token amount to ether based on the exchange rate.
            // SWC-Integer Overflow and Underflow: L562
            return _amount.mul(rate).div(magnitude);
        }
        return 0;
    }
}