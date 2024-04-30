contract Migrations {
  address public owner = msg.sender;
  uint public last_completed_migration;

  modifier restricted() {
    require(<FILL_ME>)
 // Error: "This function is restricted to the contract's owner"
    _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }
}