//
//  AppState.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import Foundation

@MainActor
final class AppState: ObservableObject {
    @Published private(set) var hasCredentials: Bool

    private let keychainService: KeychainService

    init(keychainService: KeychainService = KeychainService()) {
        self.keychainService = keychainService
        self.hasCredentials = (try? keychainService.loadCredentials()) != nil
    }

    func completeSetup() {
        hasCredentials = true
        triggerInitialSync()
    }

    func removeCredentials() {
        do {
            try keychainService.deleteCredentials()
        } catch {
            hasCredentials = false
            return
        }
        resetLocalData()
        hasCredentials = false
    }

    private func triggerInitialSync() {
        // TODO: Integrate initial data sync once caching is implemented.
    }

    private func resetLocalData() {
        // TODO: Clear SQLite cache and widget snapshot data when implemented.
    }
}
