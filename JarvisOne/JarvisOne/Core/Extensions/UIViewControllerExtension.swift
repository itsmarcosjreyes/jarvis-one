import UIKit

extension UIViewController {
    static func instantiate(_ storyboard: StoryboardName) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        let className = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: className) as? Self ?? Self()
    }
}

extension UIViewController {
    func setNavigationStyle(for navigationType: NavigationType) {
        setCoreNavigationStyle()
        guard let viewController = self as? ModalDismissable else {
            return
        }

        switch navigationType {
        case .dismissOnly:
            setCloseBarButtonItem(for: viewController)
        }
    }

    func setCoreNavigationStyle() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .jvoPrimary
        navigationController?.navigationBar.barTintColor = .jvoBackground
    }

    func setCloseBarButtonItem(for viewController: ModalDismissable) {
        let xIconButton = UIBarButtonItem(image: .jvoCloseXIcon.resizeImage(.jvoSpace32, opaque: false), style: .plain, target: viewController, action: #selector(viewController.dismissVC))
        navigationItem.rightBarButtonItems = [xIconButton]
    }
}

extension UIViewController {
    func hideKeyboardIfNeeded() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
