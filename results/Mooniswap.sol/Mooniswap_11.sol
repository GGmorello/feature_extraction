// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/Math.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./interfaces/IReferralFeeReceiver.sol";
import "./libraries/UniERC20.sol";
import "./libraries/Sqrt.sol";
import "./libraries/VirtualBalance.sol";
import "./governance/MooniswapGovernance.sol";
contract Mooniswap is MooniswapGovernance, Ownable {
    using Sqrt for uint256;
    using SafeMath for uint256;
    using UniERC20 for IERC20;
    using VirtualBalance for VirtualBalance.Data;
    struct Balances {
        uint256 src;
        uint256 dst;
    }
    struct SwapVolumes {
        uint128 confirmed;
        uint128 result;
    }
    struct Fees {
        uint256 fee;
        uint256 slippageFee;
    }
    event Deposited(
        address indexed sender,
        address indexed receiver,
        uint256 share,
        uint256 token0Amount,
        uint256 token1Amount
    );
    event Withdrawn(
        address indexed sender,
        address indexed receiver,
        uint256 share,
        uint256 token0Amount,
        uint256 token1Amount
    );
    event Swapped(
        address indexed sender,
        address indexed receiver,
        address indexed srcToken,
        address dstToken,
        uint256 amount,
        uint256 result,
        uint256 srcAdditionBalance,
        uint256 dstRemovalBalance,
        address referral
    );
    event Sync(
        uint256 srcBalance,
        uint256 dstBalance,
        uint256 fee,
        uint256 slippageFee,
        uint256 referralShare,
        uint256 governanceShare
    );
    uint256 private constant _BASE_SUPPLY = 1000;  // Total supply on first deposit
    IERC20 public immutable token0;
    IERC20 public immutable token1;
    mapping(IERC20 => SwapVolumes) public volumes;
    mapping(IERC20 => VirtualBalance.Data) public virtualBalancesForAddition;
    mapping(IERC20 => VirtualBalance.Data) public virtualBalancesForRemoval;
    constructor(
        IERC20 _token0,
        IERC20 _token1,
        string memory name,
        string memory symbol,
        IMooniswapFactoryGovernance _mooniswapFactoryGovernance
    )
        public
        ERC20(name, symbol)
        MooniswapGovernance(_mooniswapFactoryGovernance)
    {
    }
    function getTokens() external view returns(IERC20[] memory tokens) {
    }
    function tokens(uint256 i) external view returns(IERC20) {
    }
    function getBalanceForAddition(IERC20 token) public view returns(uint256) {
    }
    function getBalanceForRemoval(IERC20 token) public view returns(uint256) {
    }
    function getReturn(IERC20 src, IERC20 dst, uint256 amount) external view returns(uint256) {
    }
    function deposit(uint256[2] memory maxAmounts, uint256[2] memory minAmounts) external payable returns(uint256 fairSupply, uint256[2] memory receivedAmounts) {
    }
    function depositFor(uint256[2] memory maxAmounts, uint256[2] memory minAmounts, address target) public payable nonReentrant returns(uint256 fairSupply, uint256[2] memory receivedAmounts) {
    }
    function withdraw(uint256 amount, uint256[] memory minReturns) external returns(uint256[2] memory withdrawnAmounts) {
    }
    function withdrawFor(uint256 amount, uint256[] memory minReturns, address payable target) public nonReentrant returns(uint256[2] memory withdrawnAmounts) {
    }
    function swap(IERC20 src, IERC20 dst, uint256 amount, uint256 minReturn, address referral) external payable returns(uint256 result) {
    }
    function swapFor(IERC20 src, IERC20 dst, uint256 amount, uint256 minReturn, address referral, address payable receiver) public payable nonReentrant returns(uint256 result) {
    }
    function _doTransfers(IERC20 src, IERC20 dst, uint256 amount, uint256 minReturn, address payable receiver, Balances memory balances, Fees memory fees)
        private returns(uint256 confirmed, uint256 result, Balances memory virtualBalances)
    {
        uint256 _decayPeriod = decayPeriod();
        virtualBalances.src = virtualBalancesForAddition[src].current(_decayPeriod, balances.src);
        virtualBalances.src = Math.max(virtualBalances.src, balances.src);
        virtualBalances.dst = virtualBalancesForRemoval[dst].current(_decayPeriod, balances.dst);
        virtualBalances.dst = Math.min(virtualBalances.dst, balances.dst);
        src.uniTransferFrom(msg.sender, address(this), amount);
        confirmed = src.uniBalanceOf(address(this)).sub(balances.src);
        result = _getReturn(src, dst, confirmed, virtualBalances.src, virtualBalances.dst, fees.fee, fees.slippageFee);
        require(<FILL_ME>);
        dst.uniTransfer(receiver, result);
        // Update virtual balances to the same direction only at imbalanced state
        if (virtualBalances.src != balances.src) {
            virtualBalancesForAddition[src].set(virtualBalances.src.add(confirmed));
        }
        if (virtualBalances.dst != balances.dst) {
            virtualBalancesForRemoval[dst].set(virtualBalances.dst.sub(result));
        }
        // Update virtual balances to the opposite direction
        virtualBalancesForRemoval[src].update(_decayPeriod, balances.src);
        virtualBalancesForAddition[dst].update(_decayPeriod, balances.dst);
    }
    function _mintRewards(uint256 confirmed, uint256 result, address referral, Balances memory balances, Fees memory fees) private {
    }
    /*
        spot_ret = dx * y / x
        uni_ret = dx * y / (x + dx)
        slippage = (spot_ret - uni_ret) / spot_ret
        slippage = dx * dx * y / (x * (x + dx)) / (dx * y / x)
        slippage = dx / (x + dx)
        ret = uni_ret * (1 - fee_percentage * slippage)
        ret = dx * y / (x + dx) * (1 - slip_fee * dx / (x + dx))
        ret = dx * y / (x + dx) * (x + dx - slip_fee * dx) / (x + dx)
        x = amount * denominator
        dx = amount * (denominator - fee)
    */
    function _getReturn(IERC20 src, IERC20 dst, uint256 amount, uint256 srcBalance, uint256 dstBalance, uint256 fee, uint256 slippageFee) internal view returns(uint256) {
    }
    // SWC-Unprotected Ether Withdrawal: L331-341
    function rescueFunds(IERC20 token, uint256 amount) external nonReentrant onlyOwner {
    }
}