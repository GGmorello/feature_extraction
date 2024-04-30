  function _safeTransfer(
    address token,
    address to,
    uint256 value
  ) private {
    (bool success, bytes memory data) = token.call(abi.encodeWithSelector(SELECTOR, to, value));
    require(<FILL_ME>)
  }