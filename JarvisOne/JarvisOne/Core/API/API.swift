import Foundation
import RxSwift
import RxAlamofire
import Alamofire

struct API {
    @discardableResult
    func makeRequest(_ endpoint: APIRequest) -> Observable<Data> {
        let maxAttempts = 3_000

        debugPrint("⚡️ Making Request :: \(endpoint)")
        return requestData(endpoint)
            .flatMap { response, data -> Observable<Data> in
                debugPrint("🌀 ClientAPI response.statusCode: \(response.statusCode)")
                if response.statusCode == 401 {
                    debugPrint("⛔️ 401 - Unauthenticated")
                    // We can always display dedicated UI to Unauthenticated access if needed
                    // For the sake of this DEMO, we just take the user back to input proper keys
                    LocalStorageService().clearUserData()
                    AppCoordinator.shared.loadAPIKeyInputVCAsRoot()
                }

                if response.statusCode == 403 {
                    debugPrint("⛔️ 403 - Unauthorized")
                }

                guard let jsonObjReceived = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    debugPrint("🌀⛔️ ClientAPI Error Invalid Data")
                    throw APIError.invalidData
                }

                if 400..<451 ~= response.statusCode {
                    debugPrint("🌀⛔️ ClientAPI Error Details: \(jsonObjReceived)")
                    throw APIError.invalidResponse(statusCode: response.statusCode, response: jsonObjReceived)
                }

                if 200..<300 ~= response.statusCode {
                    // anything special to handle, any flags to unset, set, etc. by using absoluteURL at this stage, we can handle very specialized logic if needed
                } else {
                    throw APIError.invalidResponse(statusCode: response.statusCode, response: jsonObjReceived)
                }

                return Observable.just(data)
            }
            .retry { observableError in
                observableError.enumerated().flatMap { attempt, error -> Observable<Int> in
                    if (attempt * 1_000) >= maxAttempts - 1_000 {
                        return Observable.error(error)
                    }
                    debugPrint("🌀 Retrying ClientAPI Call to Endpoint: \(endpoint.path) - After \((attempt * 1_000) + 1_000) milliseconds...")
                    return Observable<Int>.timer(.milliseconds(attempt + 1_000), scheduler: MainScheduler.instance).take(1)
                }
            }
    }
}
