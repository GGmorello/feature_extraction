contract ControllableOwnable is Controllable, Ownable {
    /// @dev Check if the sender is the Owner or one of the Controllers
    modifier onlyOwnerOrController() {
        require(<FILL_ME>)
        _;
    }
}