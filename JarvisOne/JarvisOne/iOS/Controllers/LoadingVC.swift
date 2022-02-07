import Foundation
import UIKit
import RxSwift

final class LoadingVC: UIViewController {
    private var viewModel: LoadingVM?
    private let bag = DisposeBag()
    weak var coordinator: AppCoordinator?
    internal var activityIndicatorView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoadingVM()
        setupUI()
        subscribe()
        viewModel?.start()
    }

    private func setupUI() {
        view.backgroundColor = .jvoBackground
    }

    private func subscribe() {
        viewModel?.loadingCompleted.subscribe { [weak self] result in
            guard let self = self else {
                return
            }
            switch result.element {
            case .loading:
                self.showActivityIndicator()

            case .completed:
                self.handleLoadingComplete()

            case .failure(let error):
                guard let jvoError = error as? JarvisOneError else {
                    return
                }

                switch jvoError {
                case .apiKeyNotFound:
                    self.handleAPIKeyNotFound()

                default:
                    // We can handle specific logic for different errors that happened during loading phase
                    break
                }

            default:
                break
            }
        }
        .disposed(by: bag)
    }

    private func handleLoadingComplete() {
        coordinator?.loadRootVC()
    }

    private func handleAPIKeyNotFound() {
        coordinator?.loadAPIKeyInputVCAsRoot()
    }
}

extension LoadingVC: ActivityIndicatorDisplayable {}
