  modifier lock() {
    require(<FILL_ME>)
    unlocked = 0;
    _;
    unlocked = 1;
  }