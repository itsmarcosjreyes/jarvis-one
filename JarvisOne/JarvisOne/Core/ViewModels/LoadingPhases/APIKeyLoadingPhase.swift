import Foundation

struct APIKeyLoadingPhase: LoadingPhase {
    private let localStorageService = LocalStorageService()
    var completionHandler: ((TaskOutcome) -> Void)?

    init() {
        debugPrint("⚙️🟢 Initializing \(String(describing: self))")
    }
}

extension APIKeyLoadingPhase {
    func run() {
        debugPrint("⚙️ Running task \(String(describing: self))")

        if let storedKey = localStorageService.storedValue(for: Constants.StoredKeys.apiToken.key, in: .keychain) as? String,
            !storedKey.isEmpty,
            let storedPrivateKey = localStorageService.storedValue(for: Constants.StoredKeys.apiTokenPrivate.key, in: .keychain) as? String,
            !storedPrivateKey.isEmpty {
            debugPrint("⚙️✅ Task successfully completed \(String(describing: self))")
            completionHandler?(.success)
        } else {
            debugPrint("⚙️❌ No API Token Found - \(String(describing: self))")
            completionHandler?(.failure(JarvisOneError.apiKeyNotFound))
        }
    }
}
