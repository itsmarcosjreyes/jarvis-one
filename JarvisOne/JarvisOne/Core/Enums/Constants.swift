import UIKit

enum Constants {
    enum StyleGuide {
        static let alpha = Alpha()
        static let color = ColorPalette()
        static let image = ImageCatalog()
        static let font = FontCatalog()
        static let spacing = Spacing()
        static let cornerRadius = CornerRadius()
    }

    enum Strings: String {
        // swiftlint:disable explicit_enum_raw_value
        case addToLibrary
        case apiKey
        case apiKeyMessage
        case apiKeyPrivate
        case apiKeyErrorMessage
        case comicId
        case comicIdInvalidMessage
        case comicNotFoundMessage
        case enterComicIdMessage
        case genericErrorCode
        case genericErrorTitle
        case genericErrorMessage
        case gotIt
        case markAsRead
        case next
        case previous
        case readNow
        case readOffline
        case search
        case unlockJarvis
        case welcomeTitle
        // swiftlint:enable explicit_enum_raw_value

        var value: String {
            return self.rawValue.localized
        }

        func format(_ arguments: [String]) -> String {
            return String(format: self.rawValue.localized, arguments: arguments)
        }
    }

    enum StoredKeys: String {
        case apiToken = "jarvisone.apiToken"
        case apiTokenPrivate = "jarvisone.apiTokenPrivate"
        case firstRun = "jarvisone.firstRun"
        case offlineReading = "jarvisone.offlineReading"

        var key: String {
            return self.rawValue
        }

        var storage: LocalStorage {
            switch self {
            case .apiToken, .apiTokenPrivate:
                return .keychain

            case .offlineReading:
                return .fileManager

            default:
                return .defaults
            }
        }
    }

    // MARK: System Strings (No localization on these)
    enum SystemStrings: String {
        case bundleId = "com.itsmarcosjreyes.JarvisOne"
        case languageKey = "jarvisOne.languageCode"

        var value: String {
            return self.rawValue
        }
    }
}
