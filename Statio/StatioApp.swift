//
//  StatioApp.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import SwiftUI

@main
struct StatioApp: App {
    @StateObject private var localizationManager = LocalizationManager()
    @StateObject private var appearanceManager = AppearanceManager()
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(localizationManager)
                .environmentObject(appearanceManager)
                .environmentObject(appState)
                .environment(
                    .locale,
                    Locale(identifier: localizationManager.language.localeIdentifier)
                )
                .preferredColorScheme(appearanceManager.appearance.colorScheme)
        }
    }
}
