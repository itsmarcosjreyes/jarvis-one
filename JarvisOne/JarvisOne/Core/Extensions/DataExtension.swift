import Foundation

extension Data {
    init<T>(from value: T) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }

    func to<T>(type: T.Type) -> T {
        withUnsafeBytes { $0.load(as: T.self) }
    }
}
