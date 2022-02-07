import Foundation

extension Date {
    func asStringForHash() -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale.current
        formatter.dateFormat = "HHddHHmmss"
        let dateISO = formatter.string(from: self)
        return dateISO
    }
}
