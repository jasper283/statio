//
//  AppStoreConnectService.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import Foundation
import AppStoreConnect

struct AppStoreConnectService {
    func verifyCredentials(_ credentials: AppStoreConnectCredentials) async throws {
        let configuration = APIConfiguration(
            issuerID: credentials.issuerID,
            privateKeyID: credentials.keyID,
            privateKey: credentials.privateKey
        )
        let provider = APIProvider(configuration: configuration)
        _ = try await provider.request(Apps.getApps())
    }
}
