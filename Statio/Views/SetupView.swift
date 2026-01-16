//
//  SetupView.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import SwiftUI

struct SetupView: View {
    @StateObject private var viewModel = SetupViewModel()
    @EnvironmentObject private var localizationManager: LocalizationManager
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text(localizationManager.localized("setup.description"))
                        .foregroundStyle(.primary)
                    Text(localizationManager.localized("setup.privacy"))
                        .foregroundStyle(.secondary)
                    Text(localizationManager.localized("setup.delay"))
                        .foregroundStyle(.secondary)
                    Link(
                        localizationManager.localized("setup.help.link"),
                        destination: URL(string: "https://developer.apple.com/help/app-store-connect/create-api-key/")
                    )
                }
            }

            Section(header: Text(localizationManager.localized("setup.credentials.section"))) {
                TextField(
                    localizationManager.localized("setup.issuerId.placeholder"),
                    text: $viewModel.issuerID
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

                TextField(
                    localizationManager.localized("setup.keyId.placeholder"),
                    text: $viewModel.keyID
                )
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

                VStack(alignment: .leading, spacing: 6) {
                    Text(localizationManager.localized("setup.privateKey.label"))
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    ZStack(alignment: .topLeading) {
                        if viewModel.privateKey.isEmpty {
                            Text(localizationManager.localized("setup.privateKey.placeholder"))
                                .foregroundStyle(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                        TextEditor(text: $viewModel.privateKey)
                            .frame(minHeight: 140)
                    }
                }
            }

            if let errorKey = viewModel.errorKey {
                Section {
                    Text(localizationManager.localized(errorKey.rawValue))
                        .foregroundStyle(.red)
                }
            }

            Section {
                Button {
                    Task {
                        let success = await viewModel.verifyAndSave()
                        if success {
                            appState.completeSetup()
                        }
                    }
                } label: {
                    if viewModel.isLoading {
                        HStack {
                            ProgressView()
                            Text(localizationManager.localized("setup.verify.loading"))
                        }
                    } else {
                        Text(localizationManager.localized("setup.verify.button"))
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)
            }
        }
    }
}

#Preview {
    SetupView()
        .environmentObject(LocalizationManager())
        .environmentObject(AppState())
}
