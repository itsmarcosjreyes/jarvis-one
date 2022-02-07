import UIKit

extension UIButton {
    func setStyle(for style: ButtonStyle, icon: UIImage? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(.white, for: .normal)
        self.tintColor = .white
        self.backgroundColor = .jvoBackgroundNonDynamic
        self.layer.cornerRadius = .jvoCornerRadiusSmall

        if let buttonImage = icon {
            self.setImage(buttonImage.tinted(with: .white).resizeImage(.jvoSpace24, opaque: false), for: .normal)
            self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 0)
            self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0)
        }

        switch style {
        case .primary:
            self.titleLabel?.font = Constants.StyleGuide.font.buttonLarge
            self.backgroundColor = .jvoButtonPrimary

        case .secondary:
            self.titleLabel?.font = Constants.StyleGuide.font.buttonRegular
            self.contentHorizontalAlignment = .left

        case .bottomNavigationLeft:
            self.titleLabel?.font = Constants.StyleGuide.font.buttonRegular
            self.contentHorizontalAlignment = .left
            self.semanticContentAttribute = .forceLeftToRight
            self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 0)
            self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0)
            self.backgroundColor = .clear

        case .bottomNavigationRight:
            self.titleLabel?.font = Constants.StyleGuide.font.buttonRegular
            self.contentHorizontalAlignment = .right
            self.semanticContentAttribute = .forceRightToLeft
            self.contentEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 4)
            self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 10.0)
            self.backgroundColor = .clear
        }
    }
}
