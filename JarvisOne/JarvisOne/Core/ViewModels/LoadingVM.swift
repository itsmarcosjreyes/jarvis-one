import Foundation
import RxSwift

final class LoadingVM: BaseVMProtocol {
    var isLoading = BehaviorSubject<Bool>(value: true)
    var loadingCompleted = BehaviorSubject<LoadingStatus>(value: .loading)
    private let loadingPhases: [LoadingPhaseType]?
    private var tasks: [LoadingPhase]?

    init() {
        // Based on environment we can add, remove or reorder Loading Phases
        // This allows us to test a new Loading Phase with our current code base
        switch GlobalEnvironment.shared.type {
        case .production:
            loadingPhases = [.apiKey]

        case .develop:
            loadingPhases = [.apiKey]
        }

        tasks = loadingPhases?.compactMap { createLoadingPhaseObject(for: $0) }
    }

    func start() {
        cleanSandboxIfNeeded()
        runNextTask(index: 0)
    }

    private func cleanSandboxIfNeeded() {
        let localStorageService = LocalStorageService()
        if localStorageService.storedValue(for: Constants.StoredKeys.firstRun.key, in: .defaults) as? Bool == nil {
            localStorageService.clearUserData()
            localStorageService.store(value: false, with: Constants.StoredKeys.firstRun.key, in: .defaults)
        }
    }

    private func createLoadingPhaseObject(for type: LoadingPhaseType) -> LoadingPhase {
        switch type {
        case .apiKey:
            return APIKeyLoadingPhase()
        }
    }

    private func runNextTask(index: Int) {
        guard let count = tasks?.count, index < count else {
            loadingCompleted.onNext(.completed)
            return
        }

        if var task = tasks?[safe: index] {
            task.completionHandler = { [weak self] outcome in
                switch outcome {
                case .success:
                    self?.runNextTask(index: index + 1)

                case.continueWith(_):
                    self?.runNextTask(index: index + 1)

                case.failure(let error):
                    self?.loadingCompleted.onNext(.failure(error))
                }
            }

            task.run()
        }
    }
}
