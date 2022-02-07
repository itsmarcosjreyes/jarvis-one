struct ComicImage: Codable {
    var path: String?
    var imgExtension: String?
}

// swiftlint:disable explicit_enum_raw_value
extension ComicImage {
    enum CodingKeys: String, CodingKey {
        case imgExtension = "extension"
        case path
    }
}
// swiftlint:enable explicit_enum_raw_value
