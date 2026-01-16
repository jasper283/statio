//
//  LocalizationManager.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case simplifiedChinese = "zh-Hans"

    var id: String { rawValue }
    var localeIdentifier: String { rawValue }
    var displayKey: String {
        switch self {
        case .english:
            return "settings.language.english"
        case .simplifiedChinese:
            return "settings.language.simplifiedChinese"
        }
    }
}

final class LocalizationManager: ObservableObject {
    private let languageKey = "settings.language"

    @Published var language: AppLanguage {
        didSet {
            UserDefaults.standard.set(language.rawValue, forKey: languageKey)
        }
    }

    init() {
        let stored = UserDefaults.standard.string(forKey: languageKey)
        self.language = AppLanguage(rawValue: stored ?? "") ?? .english
    }

    var bundle: Bundle {
        guard let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return .main
        }
        return bundle
    }

    func localized(_ key: String) -> String {
        String(localized: String.LocalizationValue(key), bundle: bundle)
    }
}
