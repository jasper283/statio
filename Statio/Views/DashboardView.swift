//
//  DashboardView.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var localizationManager: LocalizationManager

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(localizationManager.localized("dashboard.placeholder"))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    DashboardView()
        .environmentObject(LocalizationManager())
}
