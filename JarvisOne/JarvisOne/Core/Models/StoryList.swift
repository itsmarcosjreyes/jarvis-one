struct StoryList: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [StorySummary]?
}
