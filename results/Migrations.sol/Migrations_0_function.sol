  modifier restricted() {
    require(<FILL_ME>)
 // Error: "This function is restricted to the contract's owner"
    _;
  }

  function setCompleted(uint completed) public restricted {