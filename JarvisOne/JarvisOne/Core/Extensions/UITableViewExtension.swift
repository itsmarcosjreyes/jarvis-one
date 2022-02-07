import Foundation
import UIKit

extension UITableView {
    func dequeReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to reuse cell")
        }

        return cell
    }

    func registerCells(_ cells: [UITableViewCell.Type]) {
        cells.forEach { self.register($0.self, forCellReuseIdentifier: $0.reuseIdentifier) }
    }

    func reloadWithCrossDissolve() {
        UIView.transition(
            with: self,
            duration: 0.15,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
                self?.reloadData()
            },
            completion: nil
        )
    }
}
