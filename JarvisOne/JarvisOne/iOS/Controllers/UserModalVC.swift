import Foundation
import UIKit
import RxSwift
import RxCocoa

final class UserModalVC: UIViewController {
    private var viewModel: UserModalVM?
    private var okButton = UIButton()
    private var closeButton = UIButton()
    internal var activityIndicatorView: UIView?
    private let bag = DisposeBag()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented for UserModalVC")
    }

    init(viewModel: UserModalVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribe()
    }

    private func setupUI() {
        guard let viewModel = self.viewModel else {
            dismissVC()
            return
        }
        view.backgroundColor = .jvoBackground.withAlphaComponent(.jvoAlphaEighty)

        let centerContainerView = UIView(frame: .zero)
        centerContainerView.translatesAutoresizingMaskIntoConstraints = false
        centerContainerView.backgroundColor = .jvoPrimary
        centerContainerView.layer.cornerRadius = .jvoCornerRadiusMedium
        centerContainerView.clipsToBounds = true

        closeButton = UIButton(frame: .zero)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(.jvoCloseXIcon.tinted(with: .jvoBackground), for: .normal)
        closeButton.tintColor = .jvoBackground

        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = viewModel.getDisplayableTitle()
        titleLabel.font = .title2Bold

        titleLabel.textColor = .jvoBackground
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        let messageLabel = UILabel(frame: .zero)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = "\(viewModel.getDisplayableMessage())\n\n\(viewModel.getDisplayableCode())"
        messageLabel.font = .title2Medium
        messageLabel.textColor = .jvoBackground
        messageLabel.numberOfLines = 0

        okButton = UIButton(frame: .zero)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle(Constants.Strings.gotIt.value, for: .normal)
        okButton.backgroundColor = .jvoBackground
        okButton.setTitleColor(.jvoPrimary, for: .normal)
        okButton.layer.cornerRadius = .jvoCornerRadiusSmall

        view.addSubview(centerContainerView)
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(okButton)

        NSLayoutConstraint.activate([
            centerContainerView.widthAnchor.constraint(equalToConstant: 280),
            centerContainerView.heightAnchor.constraint(equalToConstant: 280),
            centerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            closeButton.topAnchor.constraint(equalTo: centerContainerView.topAnchor, constant: .jvoSpace16),
            closeButton.trailingAnchor.constraint(equalTo: centerContainerView.trailingAnchor, constant: -.jvoSpace16),
            closeButton.widthAnchor.constraint(equalToConstant: .jvoSpace40),
            closeButton.heightAnchor.constraint(equalToConstant: .jvoSpace40),

            titleLabel.topAnchor.constraint(equalTo: centerContainerView.topAnchor, constant: .jvoSpace48),
            titleLabel.leadingAnchor.constraint(equalTo: centerContainerView.leadingAnchor, constant: .jvoSpace16),
            titleLabel.trailingAnchor.constraint(equalTo: centerContainerView.trailingAnchor, constant: -.jvoSpace16),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .jvoSpace24),
            messageLabel.leadingAnchor.constraint(equalTo: centerContainerView.leadingAnchor, constant: .jvoSpace16),
            messageLabel.trailingAnchor.constraint(equalTo: centerContainerView.trailingAnchor, constant: -.jvoSpace16),

            okButton.heightAnchor.constraint(equalToConstant: .jvoSpace48),
            okButton.bottomAnchor.constraint(equalTo: centerContainerView.bottomAnchor, constant: -.jvoSpace16),
            okButton.leadingAnchor.constraint(equalTo: centerContainerView.leadingAnchor, constant: .jvoSpace16),
            okButton.trailingAnchor.constraint(equalTo: centerContainerView.trailingAnchor, constant: -.jvoSpace16)
        ])
    }

    private func subscribe() {
        viewModel?.isLoading.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.showActivityIndicator()
                } else {
                    self?.hideActivityIndicator()
                    self?.dismissVC()
                }
            })
            .disposed(by: bag)

        okButton.rx.tap
            .subscribe { [weak self] event in
                self?.viewModel?.start()
            }
            .disposed(by: bag)

        closeButton.rx.tap
            .subscribe { [weak self] event in
                self?.viewModel?.start()
            }
            .disposed(by: bag)
    }

    private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}

extension UserModalVC: ActivityIndicatorDisplayable {}
