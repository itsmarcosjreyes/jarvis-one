import Foundation

enum APIError: Error {
    case invalidResponse(statusCode: Int, response: [String: Any])
    case unauthorized
    case invalidData

    var response: [String: Any] {
        switch self {
        case .invalidResponse(_, let response):
            return response

        default:
            return [:]
        }
    }
}
