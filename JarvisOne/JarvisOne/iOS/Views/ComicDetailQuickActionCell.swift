import UIKit
import RxSwift
import RxCocoa

final class ComicDetailQuickActionCell: UITableViewCell {
    var comicFormatter: ComicFormatter? {
        didSet {
            setComicDetails()
        }
    }
    var bag: DisposeBag = DisposeBag()
    // We could use closures to give functionality to the buttons
    // these closures would simply call functions in the viewModel
    var readNowClosure: (() -> Void)?
    var markAsReadClosure: (() -> Void)?
    var addToLibraryClosure: (() -> Void)?
    var readOfflineClosure: (() -> Void)?

    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = .jvoPlaceholder
        return image
    }()

    private lazy var comicImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = .jvoCornerRadiusSmall
        image.clipsToBounds = true
        image.image = .jvoPlaceholder
        return image
    }()

    private lazy var readNowButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(Constants.Strings.readNow.value.uppercased(), for: .normal)
        button.setStyle(for: .primary)
        return button
    }()

    private lazy var markAsReadButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(Constants.Strings.markAsRead.value, for: .normal)
        button.setStyle(for: .secondary, icon: .jvoMarkAsRead)
        return button
    }()

    private lazy var addToLibraryButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(Constants.Strings.addToLibrary.value, for: .normal)
        button.setStyle(for: .secondary, icon: .jvoAddToLibrary)
        return button
    }()

    private lazy var readOfflineButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(Constants.Strings.readOffline.value, for: .normal)
        button.setStyle(for: .secondary, icon: .jvoReadOffline)
        return button
    }()

    private lazy var verticalButtonsStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.spacing = .jvoSpace12
        stack.axis = .vertical
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        comicFormatter = nil
    }

    private func setupLayout() {
        backgroundColor = .clear

        contentView.addSubview(backgroundImageView)
        backgroundImageView.addBlur()
        contentView.addSubview(comicImageView)
        contentView.addSubview(verticalButtonsStackView)

        NSLayoutConstraint.activate([
            readNowButton.heightAnchor.constraint(equalToConstant: .jvoSpace48),
            markAsReadButton.heightAnchor.constraint(equalToConstant: .jvoSpace40),
            addToLibraryButton.heightAnchor.constraint(equalToConstant: .jvoSpace40),
            readOfflineButton.heightAnchor.constraint(equalToConstant: .jvoSpace40)
        ])
        verticalButtonsStackView.addArrangedSubview(readNowButton)
        verticalButtonsStackView.addArrangedSubview(markAsReadButton)
        verticalButtonsStackView.addArrangedSubview(addToLibraryButton)
        verticalButtonsStackView.addArrangedSubview(readOfflineButton)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 300.0),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            comicImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .jvoSpace24),
            comicImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .jvoSpaceGutter),
            comicImageView.widthAnchor.constraint(equalToConstant: 164.0),
            comicImageView.heightAnchor.constraint(equalToConstant: 250.0),

            verticalButtonsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .jvoSpace24),
            verticalButtonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.jvoSpaceGutter),
            verticalButtonsStackView.leadingAnchor.constraint(equalTo: comicImageView.trailingAnchor, constant: .jvoSpaceGutter)
        ])
    }

    private func setComicDetails() {
        guard let formatter = comicFormatter else {
            return
        }
        backgroundImageView.setImage(with: formatter.posterImage())
        comicImageView.setImage(with: formatter.posterThumbnailImage())
    }
}
