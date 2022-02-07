import UIKit

typealias JarvisOneErrorMessage = (title: String, message: String, code: String)

enum JarvisOneError: Error {
    // MARK: API Key
    case apiKeyNotFound
    case apiKeySeemsInvalid
    case apiKeyPrivateSeemsInvalid
    case comicIdSeemsInvalid
    case comicNotFound(id: Int)

    var message: JarvisOneErrorMessage {
        switch self {
        case .apiKeyNotFound:
            return (Constants.Strings.apiKey.value, Constants.Strings.apiKeyMessage.value, "Code \(code)")

        case .apiKeySeemsInvalid:
            return (Constants.Strings.apiKey.value, Constants.Strings.apiKeyErrorMessage.value, "Code \(code)")

        case .apiKeyPrivateSeemsInvalid:
            return (Constants.Strings.apiKeyPrivate.value, Constants.Strings.apiKeyErrorMessage.value, "Code \(code)")

        case .comicIdSeemsInvalid:
            return (Constants.Strings.comicId.value, Constants.Strings.comicIdInvalidMessage.value, "Code \(code)")

        case .comicNotFound:
            return (Constants.Strings.genericErrorTitle.value, Constants.Strings.comicNotFoundMessage.value, "Code \(code)")
        }
    }

    var code: String {
        switch self {
        case .apiKeyNotFound:
            return "JO1001"

        case .apiKeySeemsInvalid:
            return "JO1002"

        case .apiKeyPrivateSeemsInvalid:
            return "JO1002B"

        case .comicIdSeemsInvalid:
            return "JO2002"

        case .comicNotFound:
            return "JO2001"
        }
    }
}

extension JarvisOneError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .apiKeyNotFound:
            return "\(code): API Key Not Found"

        case .apiKeySeemsInvalid:
            return "\(code): API Key (Public) Seems Invalid"

        case .apiKeyPrivateSeemsInvalid:
            return "\(code): API Key (Private) Seems Invalid"

        case .comicIdSeemsInvalid:
            return "\(code): Comic ID Seems Invalid"

        case .comicNotFound(let id):
            return "\(code)-\(id): Comic Not Found"
        }
    }
}

// MARK: User Facing Error Modal
extension JarvisOneError {
    func displayModal() {
        let modalVM: UserModalVM = UserModalVM(with: self.message)
        let modalVC = UserModalVC(viewModel: modalVM)
        if let topVC = UIApplication.getTopViewController() {
            topVC.present(modalVC, animated: true, completion: nil)
        }
    }
}
