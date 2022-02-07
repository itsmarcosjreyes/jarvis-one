import UIKit

extension UIView {
    func removeCornerRadius() {
        layer.cornerRadius = .jvoCornerRadiusNone
    }

    func applyCornerRadius(_ radius: CGFloat = .jvoCornerRadiusXSmall) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func topRounded(_ radius: CGFloat) {
        self.roundCorners(corners: [.topLeft, .topRight], radius: radius)
    }

    func bottomRounded(_ radius: CGFloat) {
        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: radius)
    }

    func topBottomRounded(_ radius: CGFloat) {
        self.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: radius)
    }

    func defaultStateForBorders() {
        self.roundCorners(corners: [], radius: 0)
    }

    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.40
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
