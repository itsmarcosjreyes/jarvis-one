import Foundation
import SwiftKeychainWrapper

protocol LocalStorageProtocol {
    func store(value: Any, with keyString: String, in storage: LocalStorage)
    func storedValue(for keyString: String, in storage: LocalStorage) -> Any?
    func remove(keyString: String, in storage: LocalStorage)
}

struct LocalStorageService: LocalStorageProtocol {
    private let keychain = KeychainWrapper(serviceName: Constants.SystemStrings.bundleId.value)
    private let defaults = UserDefaults.standard

    func store(value: Any, with keyString: String, in storage: LocalStorage) {
        switch storage {
        case .keychain:
            if let stringVal = value as? String {
                keychain.set(stringVal, forKey: keyString, withAccessibility: .always)
            } else {
                let data = Data(from: value)
                keychain.set(data, forKey: keyString, withAccessibility: .always)
            }

        case .defaults:
            defaults.setValue(value, forKey: keyString)

        default:
            break
        }
    }

    func storedValue(for keyString: String, in storage: LocalStorage) -> Any? {
        switch storage {
        case .keychain:
            let savedType = getSavedValueTypeFromKeychain(for: keyString)

            if savedType == .string {
                return keychain.string(forKey: keyString)
            } else {
                return keychain.data(forKey: keyString)
            }

        case .defaults:
            return defaults.value(forKey: keyString)

        default:
            return nil
        }
    }

    func remove(keyString: String, in storage: LocalStorage) {
        switch storage {
        case .keychain:
            keychain.removeObject(forKey: keyString)

        case .defaults:
            defaults.removeObject(forKey: keyString)

        default:
            break
        }
    }

    func clearUserData() {
        clearUserDefaults()
        clearKeychain()
    }

    private func clearUserDefaults() {
        guard let appBundleIdentifier = Bundle.main.bundleIdentifier else {
            return
        }
        defaults.removePersistentDomain(forName: appBundleIdentifier)
    }

    private func clearKeychain() {
        KeychainWrapper.wipeKeychain()
    }

    private func getSavedValueTypeFromKeychain(for keyString: String) -> KeychainSavedValueType {
        switch keyString {
        case Constants.StoredKeys.apiToken.key, Constants.StoredKeys.apiTokenPrivate.key:
            return .string

        default:
            return .data
        }
    }
}
