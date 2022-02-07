import Foundation
import UIKit

extension UIImage {
    func resizeImage(_ dimension: CGFloat, opaque: Bool) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage
        let size = self.size
        let aspectRatio = size.width / size.height
        if aspectRatio > 1 {
            // Landscape image
            width = dimension
            height = dimension / aspectRatio
        } else {
            // Portrait image
            height = dimension
            width = dimension * aspectRatio
        }
        let renderFormat = UIGraphicsImageRendererFormat.default()
        renderFormat.opaque = opaque
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
        newImage = renderer.image { context in
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        return newImage
    }

    func tinted(with color: UIColor) -> UIImage {
        if #available(iOS 13.0, *) {
            return self.withTintColor(color)
        } else {
            UIGraphicsBeginImageContext(self.size)
            guard let context = UIGraphicsGetCurrentContext() else {
                return self
            }
            guard let cgImage = cgImage else {
                return self
            }

            // flip the image
            context.scaleBy(x: 1.0, y: -1.0)
            context.translateBy(x: 0.0, y: -size.height)

            // multiply blend mode
            context.setBlendMode(.multiply)

            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            context.clip(to: rect, mask: cgImage)
            color.setFill()
            context.fill(rect)

            // create uiimage
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
                return self
            }
            UIGraphicsEndImageContext()

            return newImage
        }
    }
}

extension UIImage {
    static var activityIndicator: UIImage = Constants.StyleGuide.image.activityIndicator
    static var jarvisOneLogoFullColor: UIImage = Constants.StyleGuide.image.jarvisOneLogoFullColor
    static var jvoAddToLibrary: UIImage = Constants.StyleGuide.image.addIconOff
    static var jvoCloseXIcon: UIImage = Constants.StyleGuide.image.closeIcon
    static var jvoMarkAsRead: UIImage = Constants.StyleGuide.image.markAsReadIconOff
    static var jvoNext: UIImage = Constants.StyleGuide.image.nextIcon
    static var jvoPlaceholder: UIImage = Constants.StyleGuide.image.placeholderSquare
    static var jvoPrevious: UIImage = Constants.StyleGuide.image.previousIcon
    static var jvoReadOffline: UIImage = Constants.StyleGuide.image.downloadIconOff
}
