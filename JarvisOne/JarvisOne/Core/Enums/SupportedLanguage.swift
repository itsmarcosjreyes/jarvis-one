// swiftlint:disable explicit_enum_raw_value
enum SupportedLanguage: String {
    case undefined
    case english = "en"
    case spanish = "es"

    var code: String {
        return self.rawValue
    }
}
// swiftlint:enable explicit_enum_raw_value
