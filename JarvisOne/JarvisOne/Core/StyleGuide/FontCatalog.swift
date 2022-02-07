import UIKit

// We can centralize all of our custom fonts in here
// We can also incorporate UIApplication.shared.preferredContentSizeCategory to be able to adjust fontSizes
// as the users wishes while still maintaining control on UI definitions and requirements

struct FontCatalog {
    var body: UIFont { UIFont.systemFont(ofSize: 13, weight: .regular) }
    var buttonLarge: UIFont { UIFont.systemFont(ofSize: 14, weight: .medium) }
    var buttonNavigation: UIFont { UIFont.systemFont(ofSize: 12, weight: .medium) }
    var buttonRegular: UIFont { UIFont.systemFont(ofSize: 12, weight: .regular) }
    var inputMedium: UIFont { UIFont.systemFont(ofSize: 14, weight: .medium) }
    var title1: UIFont { UIFont.systemFont(ofSize: 24, weight: .regular) }
    var title1Medium: UIFont { UIFont.systemFont(ofSize: 24, weight: .medium) }
    var title1Bold: UIFont { UIFont.systemFont(ofSize: 24, weight: .bold) }
    var title1Thin: UIFont { UIFont.systemFont(ofSize: 24, weight: .thin) }
    var title2: UIFont { UIFont.systemFont(ofSize: 16, weight: .regular) }
    var title2Medium: UIFont { UIFont.systemFont(ofSize: 16, weight: .medium) }
    var title2Bold: UIFont { UIFont.systemFont(ofSize: 16, weight: .bold) }
    var title3: UIFont { UIFont.systemFont(ofSize: 14, weight: .regular) }
    var title3Medium: UIFont { UIFont.systemFont(ofSize: 14, weight: .medium) }
    var title3Bold: UIFont { UIFont.systemFont(ofSize: 14, weight: .bold) }
}
