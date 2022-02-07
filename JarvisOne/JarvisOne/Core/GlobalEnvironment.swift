import Foundation

final class GlobalEnvironment {
    static let shared = GlobalEnvironment()

    public private(set) var type: EnvironmentType = .develop

    init() {
        setEnvironmentType()
    }

    private func setEnvironmentType() {
        // swiftlint:disable legacy_objc_type
        // for iOS-Debug and tvOS-Debug, the only change truly happens in the Build Arguments inside the scheme but it mimics production
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path), let envString = dict["Configuration"] as? String {
            if envString == "Release" {
                type = .production
            } else if envString == "Debug" {
                type = .develop
            }
        }
        // swiftlint:enable legacy_objc_type
    }
}
