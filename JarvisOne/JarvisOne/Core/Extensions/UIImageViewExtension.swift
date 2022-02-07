import UIKit
import SDWebImage

// By having this extension, we can easily swap out SDWebImage by another library or
// another internal implementation and we would only need to modify this one file
extension UIImageView {
    func setImage(with urlString: String, placeholder: String = "placeholder-square") {
        self.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage.jvoPlaceholder)
    }
}
