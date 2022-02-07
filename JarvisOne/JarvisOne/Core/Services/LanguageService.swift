import Foundation

class LanguageService {
    static let shared = LanguageService()

    private var localeBundle: Bundle?
    private var defaultLanguage: SupportedLanguage = .english

    private var language: SupportedLanguage = SupportedLanguage.english {
        didSet {
            let currentLanguage = language.rawValue
            UserDefaults.standard.setValue(currentLanguage, forKey: Constants.SystemStrings.languageKey.value)
            UserDefaults.standard.synchronize()

            setLocaleWith(currentLanguage)
        }
    }

    var current: SupportedLanguage {
        return language
    }

    private init() {
        prepareDefaultLocaleBundle()
    }

    // Using this function, we can switch language "on the fly" as needed
    func switchTo(_ lang: SupportedLanguage) {
        language = lang
        NotificationCenter.default.post(name: .didDetectLanguageSwitch, object: nil, userInfo: nil)
    }

    func localizedString(_ key: String) -> String {
        guard let bundle = localeBundle else {
            return NSLocalizedString(key, comment: "")
        }

        return NSLocalizedString(key, bundle: bundle, comment: "")
    }

    private func clearLanguages() {
        UserDefaults.standard.setValue(nil, forKey: Constants.SystemStrings.languageKey.value)
        UserDefaults.standard.synchronize()
    }

    private func prepareDefaultLocaleBundle() {
        var currentLanguage = UserDefaults.standard.object(forKey: Constants.SystemStrings.languageKey.value)
        if currentLanguage == nil {
            currentLanguage = defaultLanguage
        }

        if let currentLanguage = currentLanguage as? String {
            updateCurrentLanguage(currentLanguage)
        }
    }

    private func updateCurrentLanguage(_ languageName: String) {
        guard let lang = SupportedLanguage(rawValue: languageName) else {
            return
        }

        language = lang
    }

    private func setLocaleWith(_ selectedLanguage: String) {
        if let pathSelected = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj"),
            let bundleSelected = Bundle(path: pathSelected) {
            localeBundle = bundleSelected
        } else if let pathDefault = Bundle.main.path(forResource: defaultLanguage.code, ofType: "lproj"),
            let bundleDefault = Bundle(path: pathDefault) {
            localeBundle = bundleDefault
        }
    }
}
