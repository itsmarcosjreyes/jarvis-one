import UIKit

struct ColorPalette {
    let background: UIColor
    let backgroundNonDynamic: UIColor
    let buttonPrimary: UIColor
    let primary: UIColor
    let secondary: UIColor

    init() {
        background = UIColor.dynamicColor(light: UIColor(hex: HexColorString.primary.rawValue), dark: UIColor(hex: HexColorString.background.rawValue))
        backgroundNonDynamic = UIColor.dynamicColor(light: UIColor(hex: HexColorString.background.rawValue), dark: UIColor(hex: HexColorString.background.rawValue))
        buttonPrimary = UIColor.dynamicColor(light: UIColor(hex: HexColorString.buttonPrimary.rawValue), dark: UIColor(hex: HexColorString.buttonPrimary.rawValue))
        primary = UIColor.dynamicColor(light: UIColor(hex: HexColorString.background.rawValue), dark: UIColor(hex: HexColorString.primary.rawValue))
        secondary = UIColor.dynamicColor(light: UIColor(hex: HexColorString.secondary.rawValue), dark: UIColor(hex: HexColorString.secondary.rawValue))
    }
}
