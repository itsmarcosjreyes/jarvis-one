import UIKit

extension UIColor {
    // swiftlint:disable identifier_name
    convenience init(hex: String) {
        let r, g, b, a: CGFloat

        var cleanedHexString: String = hex
        if !hex.hasPrefix("#") {
            cleanedHexString = "#" + hex
        }

        if cleanedHexString.hasPrefix("#") {
            let start = cleanedHexString.index(cleanedHexString.startIndex, offsetBy: 1)
            var hexColor = String(cleanedHexString[start...])

            // If the count is 6, then we are missing the alpha values in the string
            if hexColor.count == 6 {
                hexColor = hexColor + "FF"
            }
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        self.init(red: 255, green: 255, blue: 255, alpha: 1)
    }
    // swiftlint:enable identifier_name

    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

    convenience init(hex: Int, opacity: CGFloat) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: opacity)
    }

    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return dark
        }
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }

    func hexString() -> String {
        let components = self.cgColor.components
        let red: CGFloat = components?[0] ?? 0.0
        let green: CGFloat = components?[1] ?? 0.0
        let blue: CGFloat = components?[2] ?? 0.0

        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255)))
        return hexString
    }
}

// By extending UIColor, we can use our palette throughout with a lot cleaner code
extension UIColor {
    static var jvoBackground = Constants.StyleGuide.color.background
    static var jvoBackgroundNonDynamic = Constants.StyleGuide.color.backgroundNonDynamic
    static var jvoButtonPrimary = Constants.StyleGuide.color.buttonPrimary
    static var jvoPrimary = Constants.StyleGuide.color.primary
    static var jvoSecondary = Constants.StyleGuide.color.secondary
}
