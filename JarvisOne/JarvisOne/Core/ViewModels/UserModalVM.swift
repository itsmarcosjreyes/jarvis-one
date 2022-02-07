import Foundation
import RxSwift

final class UserModalVM: BaseVMProtocol {
    var isLoading = BehaviorSubject<Bool>(value: false)
    private var errorForDisplay: JarvisOneErrorMessage?
    private var okActionCallback: (() -> Void)?

    init(with error: JarvisOneErrorMessage, okAction: (() -> Void)? = nil) {
        self.errorForDisplay = error
    }

    func start() {
        okActionCallback?()
        isLoading.onNext(false)
    }

    func getDisplayableTitle() -> String {
        return errorForDisplay?.title ?? Constants.Strings.genericErrorTitle.value
    }

    func getDisplayableMessage() -> String {
        return errorForDisplay?.message ?? Constants.Strings.genericErrorMessage.value
    }

    func getDisplayableCode() -> String {
        return errorForDisplay?.code ?? Constants.Strings.genericErrorCode.value
    }
}
