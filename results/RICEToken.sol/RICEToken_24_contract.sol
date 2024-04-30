contract RICEToken is ERC20, ERC20Detailed, ERC20Capped, ERC20Pausable, ERC20Burnable, Ownable {
//SWC-State Variable Default Visibility:L891-894, 912-914
    address FoundingTeam = 0x12B8665E7b4684178a54122e121B83CC41d9d9C3;
    address UserAcquisition = 0xdf7E62218B2f889a35a5510e65f9CD4288CB6D6E;
    address PublicSales = 0x876443e20778Daa70BFd2552e815A674D0aA7BF8;
    address PrivateSales = 0x20b803C1d5C9408Bdc5D76648A6F23EB519CD2bD;

    struct LockTime {
        uint256  releaseDate;
        uint256  amount;
    }

    mapping (address => LockTime[]) public lockList;
    mapping (uint => uint) public FoundingTeamMap;
    mapping (uint => uint) public PrivateSalesMap;

    struct Investor {
        address  wallet;
        uint256  amount;
    }

    mapping (uint => Investor) public investorsList;

    uint8 private _d = 18;
    uint256 private totalTokens = 1000000000 * 10 ** uint256(_d);
    uint256 private initialSupply = 600000000 * 10 ** uint256(_d);

    address [] private lockedAddressList;

    constructor() public ERC20Detailed("RICE", "RICE", _d) ERC20Capped(totalTokens) {
        _mint(owner(), initialSupply);

        FoundingTeamMap[1]=1658275200; // 2022-07-20T00:00:00Z
        FoundingTeamMap[2]=1689811200; // 2023-07-20T00:00:00Z
        FoundingTeamMap[3]=1721433600; // 2024-07-20T00:00:00Z
        FoundingTeamMap[4]=1752969600; // 2025-07-20T00:00:00Z
        FoundingTeamMap[5]=1784505600; // 2026-07-20T00:00:00Z

        PrivateSalesMap[1]=1634688000; // 2021-10-20T00:00:00Z
        PrivateSalesMap[2]=1642636800; // 2022-01-20T00:00:00Z
        PrivateSalesMap[3]=1650412800; // 2022-04-20T00:00:00Z
        PrivateSalesMap[4]=1658275200; // 2022-07-20T00:00:00Z
        PrivateSalesMap[5]=1666224000; // 2022-10-20T00:00:00Z
        PrivateSalesMap[6]=1674172800; // 2023-01-20T00:00:00Z
        PrivateSalesMap[7]=1681948800; // 2023-04-20T00:00:00Z
        PrivateSalesMap[8]=1689811200; // 2023-07-20T00:00:00Z
        PrivateSalesMap[9]=1697760000; // 2023-10-20T00:00:00Z
        PrivateSalesMap[10]=1705708800; // 2024-01-20T00:00:00Z

        for(uint i = 1; i <= 5; i++) {
            transferWithLock(FoundingTeam, 30000000 * 10 ** uint256(decimals()), FoundingTeamMap[i]);
        }

        investorsList[1] = Investor({wallet: 0xaDd68b582C54004aaa7eEefA849e47671023Fb9c, amount: 25000000});
        investorsList[2] = Investor({wallet: 0x05f56BA72F05787AD57b6A5b803f2b92b9faa294, amount: 2500000});
        investorsList[3] = Investor({wallet: 0xaC13b80e2880A5e0A4630039273FEefc91315638, amount: 3500000});
        investorsList[4] = Investor({wallet: 0xDe4F4Fd9AE375196cDC22b891Dd13f019d5dd64C, amount: 2500000});
        investorsList[5] = Investor({wallet: 0x0794c84AF1280D25D3CbED6256E11B33F426d59f, amount: 500000});
        investorsList[6] = Investor({wallet: 0x788152f1b4610B74686C5E774e57B9E0986E958c, amount: 1000000});
        investorsList[7] = Investor({wallet: 0x68dCfB21d343b7bD85599a30aAE2521788E09eB7, amount: 5000000});
        investorsList[8] = Investor({wallet: 0xcbf155A2Ec6C35F5af1C2a1dF1bC3BB49980645B, amount: 15000000});
        investorsList[9] = Investor({wallet: 0x7B9f1e95e08A09680c3DB9Fe95b7faEC574a8bBD, amount: 12500000});
        investorsList[10] = Investor({wallet: 0x20b803C1d5C9408Bdc5D76648A6F23EB519CD2bD, amount: 100000000});
        investorsList[11] = Investor({wallet: 0xf6e6715E0B075178c39D07386bE1bf55BAFd9180, amount: 57500000});
        investorsList[12] = Investor({wallet: 0xaCCa1EF5efA7D2C5e8AcAC07F35cD939C1b0C960, amount: 15000000});

        transfer(UserAcquisition, 200000000 * 10 ** uint256(decimals()));
        transfer(PublicSales, 10000000 * 10 ** uint256(decimals()));

    }
//SWC-Requirement Violation:L962, 969, 970, 975
    function transfer(address _receiver, uint256 _amount) public returns (bool success) {
        require(_receiver != address(0));
        require(_amount <= getAvailableBalance(msg.sender));
        return ERC20.transfer(_receiver, _amount);
    }
//SWC-Incorrect Inheritance Order:L963,971
    function transferFrom(address _from, address _receiver, uint256 _amount) public returns (bool) {
        require(<FILL_ME>)
        require(_receiver != address(0));
        require(_amount <= allowance(_from, msg.sender));
        require(_amount <= getAvailableBalance(_from));
        return ERC20.transferFrom(_from, _receiver, _amount);
    }
//SWC-Unexpected Ether Balance,SWC-DoS With Block Gas Limit:L974-984
    function transferWithLock(address _receiver, uint256 _amount, uint256 _releaseDate) public returns (bool success) {
        require(msg.sender == FoundingTeam || msg.sender == PrivateSales || msg.sender == owner());
        ERC20._transfer(msg.sender,_receiver,_amount);

        if (lockList[_receiver].length==0) lockedAddressList.push(_receiver);

        LockTime memory item = LockTime({amount:_amount, releaseDate:_releaseDate});
        lockList[_receiver].push(item);

        return true;
    }

    function getLockedAmount(address lockedAddress) public view returns (uint256 _amount) {
        uint256 lockedAmount =0;
        for(uint256 j = 0; j<lockList[lockedAddress].length; j++) {
            if(now < lockList[lockedAddress][j].releaseDate) {
                uint256 temp = lockList[lockedAddress][j].amount;
                lockedAmount += temp;
            }
        }
        return lockedAmount;
    }

    function getAvailableBalance(address lockedAddress) public view returns (uint256 _amount) {
        uint256 bal = balanceOf(lockedAddress);
        uint256 locked = getLockedAmount(lockedAddress);
        return bal.sub(locked);
    }

    function getLockedAddresses() public view returns (address[] memory) {
        return lockedAddressList;
    }

    function getNumberOfLockedAddresses() public view returns (uint256 _count) {
        return lockedAddressList.length;
    }

    function getNumberOfLockedAddressesCurrently() public view returns (uint256 _count) {
        uint256 count=0;
        for(uint256 i = 0; i<lockedAddressList.length; i++) {
            if (getLockedAmount(lockedAddressList[i])>0) count++;
        }
        return count;
    }

    function getLockedAddressesCurrently() public view returns (address[] memory) {
        address [] memory list = new address[](getNumberOfLockedAddressesCurrently());
        uint256 j = 0;
        for(uint256 i = 0; i<lockedAddressList.length; i++) {
            if (getLockedAmount(lockedAddressList[i])>0) {
                list[j] = lockedAddressList[i];
                j++;
            }
        }

        return list;
    }

    function getLockedAmountTotal() public view returns (uint256 _amount) {
        uint256 sum =0;
        for(uint256 i = 0; i<lockedAddressList.length; i++) {
            uint256 lockedAmount = getLockedAmount(lockedAddressList[i]);
            sum = sum.add(lockedAmount);
        }
        return sum;
    }

    function getCirculatingSupplyTotal() public view returns (uint256 _amount) {
        return totalSupply().sub(getLockedAmountTotal());
    }

    function getBurnedAmountTotal() public view returns (uint256 _amount) {
        return totalTokens.sub(totalSupply());
    }

    function burn(uint256 _amount) public {
        _burn(msg.sender, _amount);
    }

    function lockInvestor(uint256 investorId) public onlyOwner {
        for(uint y = 3; y <= 10; y++) {
            transferWithLock(investorsList[investorId].wallet, (investorsList[investorId].amount / 8) * 10 ** uint256(decimals()), PrivateSalesMap[y]);
        }
    }
//SWC-Integer Overflow and Underflow:L1055
    function () payable external {
        revert();
    }

}