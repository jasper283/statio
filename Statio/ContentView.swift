//
//  ContentView.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var localizationManager: LocalizationManager
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            Group {
                if appState.hasCredentials {
                    DashboardView()
                } else {
                    SetupView()
                }
            }
            .navigationTitle(titleText)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView()
                            .navigationTitle(localizationManager.localized("settings.title"))
                    } label: {
                        Image(systemName: "gearshape")
                            .accessibilityLabel(localizationManager.localized("settings.title"))
                    }
                }
            }
        }
    }

    private var titleText: String {
        appState.hasCredentials
            ? localizationManager.localized("dashboard.title")
            : localizationManager.localized("setup.title")
    }
}

#Preview {
    ContentView()
        .environmentObject(LocalizationManager())
        .environmentObject(AppState())
}
