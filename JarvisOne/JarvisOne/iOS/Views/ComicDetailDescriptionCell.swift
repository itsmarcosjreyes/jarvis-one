import UIKit

final class ComicDetailDescriptionCell: UITableViewCell {
    var comicFormatter: ComicFormatter? {
        didSet {
            setComicDetails()
        }
    }

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.StyleGuide.font.body
        label.textColor = .jvoPrimary
        label.numberOfLines = 0
        return label
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

        contentView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .jvoSpaceGutter),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .jvoSpaceGutter),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.jvoSpaceGutter),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.jvoSpaceGutter)
        ])
    }

    private func setComicDetails() {
        guard let formatter = comicFormatter else {
            return
        }
        descriptionLabel.text = formatter.description()
    }
}
