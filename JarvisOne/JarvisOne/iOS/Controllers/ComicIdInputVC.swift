import Foundation
import UIKit
import RxSwift
import RxCocoa

final class ComicIdInputVC: UIViewController {
    private var viewModel: ComicIdInputVM?
    private var inputTextField = UITextField()
    private var inputPrivateTextField = UITextField()
    private var proceedButton = UIButton()
    internal var activityIndicatorView: UIView?
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ComicIdInputVM()
        hideKeyboardIfNeeded()
        setupUI()
        subscribe()
    }

    private func setupUI() {
        view.backgroundColor = .jvoBackground

        let logoImageView = UIImageView(frame: .zero)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = .jarvisOneLogoFullColor
        logoImageView.contentMode = .scaleAspectFit

        let inputHeadingLabel = UILabel(frame: .zero)
        inputHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        inputHeadingLabel.text = Constants.Strings.enterComicIdMessage.value
        inputHeadingLabel.font = .title2Medium
        inputHeadingLabel.numberOfLines = 0

        let inputTextFieldContainer = UIView(frame: .zero)
        inputTextFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        inputTextFieldContainer.layer.cornerRadius = .jvoCornerRadiusSmall
        inputTextFieldContainer.layer.borderColor = UIColor.jvoButtonPrimary.cgColor
        inputTextFieldContainer.layer.borderWidth = 1.0

        inputTextField = UITextField(frame: .zero)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.placeholder = Constants.Strings.comicId.value
        inputTextField.keyboardType = .numberPad
        inputTextField.setStyle()

        proceedButton = UIButton(frame: .zero)
        proceedButton.translatesAutoresizingMaskIntoConstraints = false
        proceedButton.setTitle(Constants.Strings.search.value, for: .normal)
        proceedButton.accessibilityIdentifier = "Search"
        proceedButton.setStyle(for: .primary)

        view.addSubview(logoImageView)
        view.addSubview(inputHeadingLabel)
        view.addSubview(inputTextFieldContainer)
        view.addSubview(inputTextField)
        view.addSubview(proceedButton)

        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 160),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .jvoSpace24),

            inputHeadingLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: .jvoSpace48),
            inputHeadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .jvoSpaceGutter),
            inputHeadingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.jvoSpaceGutter),

            inputTextFieldContainer.topAnchor.constraint(equalTo: inputHeadingLabel.bottomAnchor, constant: .jvoSpace16),
            inputTextFieldContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .jvoSpaceGutter),
            inputTextFieldContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.jvoSpaceGutter),
            inputTextFieldContainer.heightAnchor.constraint(equalToConstant: .jvoSpace48),

            inputTextField.topAnchor.constraint(equalTo: inputTextFieldContainer.topAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: inputTextFieldContainer.bottomAnchor),
            inputTextField.leadingAnchor.constraint(equalTo: inputTextFieldContainer.leadingAnchor, constant: .jvoSpace8),
            inputTextField.trailingAnchor.constraint(equalTo: inputTextFieldContainer.trailingAnchor, constant: -.jvoSpace8),

            proceedButton.topAnchor.constraint(equalTo: inputTextFieldContainer.bottomAnchor, constant: .jvoSpace48),
            proceedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .jvoSpaceGutter),
            proceedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.jvoSpaceGutter),
            proceedButton.heightAnchor.constraint(equalToConstant: .jvoSpace48)
        ])
    }

    private func subscribe() {
        viewModel?.isLoading.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.showActivityIndicator()
                } else {
                    self?.hideActivityIndicator()
                }
            })
            .disposed(by: bag)

        inputTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .subscribe { [weak self] _ in
                self?.inputPrivateTextField.becomeFirstResponder()
            }
            .disposed(by: bag)

        inputTextField.rx.controlEvent(.editingChanged)
            .subscribe(onNext: { [weak self] input in
                self?.viewModel?.setComicIdInput("\(self?.inputTextField.text ?? "")")
            })
            .disposed(by: bag)

        proceedButton.rx.tap
            .subscribe { [weak self] event in
                self?.inputTextField.resignFirstResponder()
                self?.viewModel?.start()
            }
            .disposed(by: bag)
    }
}

extension ComicIdInputVC: ActivityIndicatorDisplayable {}
