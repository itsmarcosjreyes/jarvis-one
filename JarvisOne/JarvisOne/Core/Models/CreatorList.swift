struct CreatorList: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [CreatorSummary]?
}
