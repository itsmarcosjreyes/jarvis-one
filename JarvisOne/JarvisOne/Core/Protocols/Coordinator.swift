import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    var parent: Coordinator? { get set }
}

extension Coordinator {
    func removeChild(_ child: Coordinator?) {
        guard let index = childCoordinators.firstIndex(where: { $0 === child }) else {
            return
        }
        childCoordinators.remove(at: index)
    }

    func presentAPIKeyInputFlow() {
        guard let navigationController = navigationController else {
            return
        }

        let presentingVC = navigationController.viewControllers.last
        let apiKeyInputVC = APIKeyInputVC()
        apiKeyInputVC.modalPresentationStyle = .fullScreen
        presentingVC?.present(apiKeyInputVC, animated: true, completion: nil)
    }

    func presentComicDetailFlow(with comicId: Int) {
        guard let navigationController = navigationController else {
            return
        }
        let child = ComicDetailCoordinator(UINavigationController())
        child.parent = self
        childCoordinators.append(child)
        child.start(with: comicId, presentingVC: navigationController.viewControllers.last)
    }
}
