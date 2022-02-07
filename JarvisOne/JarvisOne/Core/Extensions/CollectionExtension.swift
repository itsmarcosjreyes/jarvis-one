import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[ index] : nil
    }

    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
