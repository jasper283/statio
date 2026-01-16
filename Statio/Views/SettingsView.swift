//
//  SettingsView.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var localizationManager: LocalizationManager
    @EnvironmentObject private var appearanceManager: AppearanceManager
    @EnvironmentObject private var appState: AppState

    @State private var showRemoveDialog = false

    var body: some View {
        Form {
            Section(header: Text(localizationManager.localized("settings.language.section"))) {
                Picker(
                    localizationManager.localized("settings.language.title"),
                    selection: $localizationManager.language
                ) {
                    ForEach(AppLanguage.allCases) { language in
                        Text(localizationManager.localized(language.displayKey))
                            .tag(language)
                    }
                }
            }

            Section(header: Text(localizationManager.localized("settings.appearance.section"))) {
                Picker(
                    localizationManager.localized("settings.appearance.title"),
                    selection: $appearanceManager.appearance
                ) {
                    ForEach(AppAppearance.allCases) { appearance in
                        Text(localizationManager.localized(appearance.displayKey))
                            .tag(appearance)
                    }
                }
            }

            Section(header: Text(localizationManager.localized("settings.credentials.section"))) {
                Button(role: .destructive) {
                    showRemoveDialog = true
                } label: {
                    Text(localizationManager.localized("settings.credentials.remove"))
                }
            }
        }
        .confirmationDialog(
            localizationManager.localized("settings.credentials.remove.confirmTitle"),
            isPresented: $showRemoveDialog
        ) {
            Button(localizationManager.localized("settings.credentials.remove.confirm"), role: .destructive) {
                appState.removeCredentials()
            }
            Button(localizationManager.localized("settings.credentials.remove.cancel"), role: .cancel) {}
        } message: {
            Text(localizationManager.localized("settings.credentials.remove.confirmMessage"))
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(LocalizationManager())
        .environmentObject(AppearanceManager())
        .environmentObject(AppState())
}
