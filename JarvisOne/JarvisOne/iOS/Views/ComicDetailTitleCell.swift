import UIKit

final class ComicDetailTitleCell: UITableViewCell {
    var comicFormatter: ComicFormatter? {
        didSet {
            setComicDetails()
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.StyleGuide.font.title1Thin
        label.textColor = .jvoPrimary
        label.numberOfLines = 0
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .jvoPrimary
        view.alpha = .jvoAlphaFiftyFive
        return view
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

        contentView.addSubview(titleLabel)
        contentView.addSubview(separatorView)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .jvoSpaceGutter),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .jvoSpaceGutter),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.jvoSpaceGutter),

            separatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .jvoSpaceGutter),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .jvoSpaceGutter),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.jvoSpaceGutter),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setComicDetails() {
        guard let formatter = comicFormatter else {
            return
        }
        titleLabel.text = formatter.title()
    }
}
