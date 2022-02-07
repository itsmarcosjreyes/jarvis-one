enum TaskOutcome {
    case success
    case continueWith(Error)
    case failure(Error)
}
