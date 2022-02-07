import Foundation
import RxSwift

protocol BaseVMProtocol {
    var isLoading: BehaviorSubject<Bool> { get }

    func start()
    func validateLoadingState()
}

extension BaseVMProtocol {
    func start() { }

    func validateLoadingState() {
        guard let vcIsLoading = try? isLoading.value() else {
            return
        }
        if vcIsLoading {
            isLoading.onNext(false)
            isLoading.onNext(true)
        } else {
            isLoading.onNext(false)
        }
    }
}
