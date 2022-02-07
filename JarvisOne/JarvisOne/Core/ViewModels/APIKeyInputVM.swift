import Foundation
import RxSwift

final class APIKeyInputVM: BaseVMProtocol {
    var isLoading = BehaviorSubject<Bool>(value: false)
    private let localStorageService = LocalStorageService()
    private var apiKey: String = ""
    private var apiKeyPrivate: String = ""

    func start() {
        isLoading.onNext(true)

        if !apiKeySeemsValid() {
            isLoading.onNext(false)
            JarvisOneError.apiKeySeemsInvalid.displayModal()
            return
        }

        if !apiKeySeemsValid(privateKey: true) {
            isLoading.onNext(false)
            JarvisOneError.apiKeyPrivateSeemsInvalid.displayModal()
            return
        }

        saveAPIKeys()
        isLoading.onNext(false)
        loadComicRootFlow()
    }

    func setAPIKeyInput(_ apiKey: String, privateKey: Bool = false) {
        if privateKey {
            self.apiKeyPrivate = apiKey
        } else {
            self.apiKey = apiKey
        }
    }

    func apiKeySeemsValid(privateKey: Bool = false) -> Bool {
        if privateKey {
            if apiKeyPrivate.isEmpty {
                return false
            }
            return true
        } else {
            if apiKey.isEmpty {
                return false
            }
            return true
        }
    }

    private func saveAPIKeys() {
        localStorageService.store(value: apiKey, with: Constants.StoredKeys.apiToken.key, in: .keychain)
        localStorageService.store(value: apiKeyPrivate, with: Constants.StoredKeys.apiTokenPrivate.key, in: .keychain)
    }

    func loadComicRootFlow() {
        AppCoordinator.shared.loadRootVC()
    }
}
