//
//  SetupViewModel.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import Foundation

@MainActor
final class SetupViewModel: ObservableObject {
    enum SetupErrorKey: String {
        case missingFields = "error.missingFields"
        case verificationFailed = "error.verifyFailed"
        case saveFailed = "error.saveFailed"
    }

    @Published var issuerID = ""
    @Published var keyID = ""
    @Published var privateKey = ""
    @Published var isLoading = false
    @Published var errorKey: SetupErrorKey?

    private let service: AppStoreConnectService
    private let keychainService: KeychainService

    init(
        service: AppStoreConnectService = AppStoreConnectService(),
        keychainService: KeychainService = KeychainService()
    ) {
        self.service = service
        self.keychainService = keychainService
    }

    func verifyAndSave() async -> Bool {
        let trimmedIssuer = issuerID.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedKeyID = keyID.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPrivateKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedIssuer.isEmpty, !trimmedKeyID.isEmpty, !trimmedPrivateKey.isEmpty else {
            errorKey = .missingFields
            return false
        }

        isLoading = true
        defer { isLoading = false }

        let credentials = AppStoreConnectCredentials(
            issuerID: trimmedIssuer,
            keyID: trimmedKeyID,
            privateKey: trimmedPrivateKey
        )

        do {
            try await service.verifyCredentials(credentials)
        } catch {
            errorKey = .verificationFailed
            return false
        }

        do {
            try keychainService.saveCredentials(credentials)
        } catch {
            errorKey = .saveFailed
            return false
        }

        errorKey = nil
        return true
    }
}
