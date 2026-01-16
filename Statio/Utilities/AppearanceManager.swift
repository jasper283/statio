//
//  AppearanceManager.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import SwiftUI

enum AppAppearance: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var displayKey: String {
        switch self {
        case .system:
            return "settings.appearance.system"
        case .light:
            return "settings.appearance.light"
        case .dark:
            return "settings.appearance.dark"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

final class AppearanceManager: ObservableObject {
    private let appearanceKey = "settings.appearance"

    @Published var appearance: AppAppearance {
        didSet {
            UserDefaults.standard.set(appearance.rawValue, forKey: appearanceKey)
        }
    }

    init() {
        let stored = UserDefaults.standard.string(forKey: appearanceKey)
        self.appearance = AppAppearance(rawValue: stored ?? "") ?? .system
    }
}
