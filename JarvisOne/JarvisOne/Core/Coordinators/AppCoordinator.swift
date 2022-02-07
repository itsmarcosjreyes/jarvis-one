import UIKit

class AppCoordinator: NSObject, Coordinator {
    static let shared = AppCoordinator(UINavigationController())
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    var parent: Coordinator?

    init (_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() -> UINavigationController {
        let viewController = LoadingVC.instantiate(.main)
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: false)
        return navigationController ?? UINavigationController()
    }

    // This is where we would set something like the Root TabBarController for the app for example
    // For the sake of this Demo, the Root is just the ComicIdInputVC
    func loadRootVC() {
        navigationController?.dismiss(animated: true, completion: nil)
        let rootVC = ComicIdInputVC()
        navigationController = UINavigationController(rootViewController: rootVC)

        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController = self.navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }

    func loadAPIKeyInputVCAsRoot() {
        navigationController = nil
        let rootVC = APIKeyInputVC()

        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController = rootVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}
