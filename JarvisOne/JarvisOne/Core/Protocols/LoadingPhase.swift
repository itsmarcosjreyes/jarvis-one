protocol LoadingPhase {
    var completionHandler: ((TaskOutcome) -> Void)? { get set }

    func run()
}
