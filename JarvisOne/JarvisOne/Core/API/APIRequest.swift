import Foundation
import Alamofire

enum APIRequest: URLRequestConvertible {
    static var baseURL: String {
        switch GlobalEnvironment.shared.type {
        case .production:
            return "https://gateway.marvel.com/"

        case .develop:
            return "https://gateway.marvel.com/"
        }
    }

    // Endpoints
    case comics(limit: Int, offset: Int)
    case comicById(_ id: Int)

    // Method
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    // Paths
    var path: String {
        switch self {
        case .comics:
            return "v1/public/comics"

        case .comicById(let id):
            return "v1/public/comics/\(id)"
        }
    }

    // URL Request
    func asURLRequest() throws -> URLRequest {
        // swiftlint:disable force_unwrapping
        // We do in fact, want a crash if a URL can't be formed from out baseURL
        let url: URL = URL(string: "\(APIRequest.baseURL)\(path)")!
        // swiftlint:enable force_unwrapping
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        // Set-up parameters
        var parameters: Parameters = getAuthenticationParameters()
        switch self {
        case .comics(let limit, let offset):
            parameters["limit"] = limit
            parameters["offset"] = offset
            let encodedURLRequest = try URLEncoding().encode(urlRequest, with: parameters)
            urlRequest = encodedURLRequest

        case .comicById(_):
            // We can take this URLEncoding outside of the switch
            // It is here to enable URLEncoding for some endpoint and JSONEncoding for others if needed
            // If we know the API will always only accept URL encoded params, then we could do that
            let encodedURLRequest = try URLEncoding().encode(urlRequest, with: parameters)

            urlRequest = encodedURLRequest
        }

        // Add default headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        urlRequest.setValue("keep-alive", forHTTPHeaderField: "Connection")

        return urlRequest
    }

    func getAuthenticationParameters() -> Parameters {
        let currDate = Date().asStringForHash()

        var publicKey = ""
        if let storedPublicKey = LocalStorageService().storedValue(for: Constants.StoredKeys.apiToken.key, in: .keychain) as? String {
            publicKey = storedPublicKey
        }

        var privateKey = ""
        if let storedPrivateKey = LocalStorageService().storedValue(for: Constants.StoredKeys.apiTokenPrivate.key, in: .keychain) as? String {
            privateKey = storedPrivateKey
        }

        let compositeString = "\(currDate)\(privateKey)\(publicKey)"
        let md5Digest = compositeString.MD5()
        let parameters: Parameters = ["apikey": publicKey, "ts": currDate, "hash": md5Digest]

        return parameters
    }
}
