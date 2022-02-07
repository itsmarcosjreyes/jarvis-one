import Foundation
import CryptoKit

extension String {
    var localized: String {
        LanguageService.shared.localizedString(self)
    }

    func MD5() -> String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
}
