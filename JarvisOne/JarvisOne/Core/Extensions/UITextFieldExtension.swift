import UIKit

extension UITextField {
    func setStyle() {
        self.font = .inputMedium
        self.textColor = .jvoPrimary
        self.tintColor = .jvoPrimary
        self.clearButtonMode = .whileEditing
        self.autocorrectionType = .no
        self.returnKeyType = .done
    }
}
