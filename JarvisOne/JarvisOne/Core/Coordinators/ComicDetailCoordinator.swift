import UIKit

class ComicDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    weak var parent: Coordinator?

    init (_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(with comicId: Int, presentingVC: UIViewController?) {
        let viewModel = ComicDetailVM(comicId: comicId)
        let viewController = ComicDetailVC(viewModel: viewModel)
        viewController.coordinator = self

        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([viewController], animated: true)

        guard let navigationController = navigationController else {
            return
        }
        presentingVC?.present(navigationController, animated: true, completion: nil)
    }

    func dismissViewController() {
        let presentingVC = parent?.navigationController?.viewControllers.last
        presentingVC?.dismiss(animated: true, completion: nil)
        parent?.removeChild(self)
        removeChild(self)
    }
}
