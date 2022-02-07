protocol DequeableCell {
    static var reuseIdentifier: String { get }
}

extension DequeableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
