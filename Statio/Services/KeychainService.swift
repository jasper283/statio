//
//  KeychainService.swift
//  Statio
//
//  Created by Jasper Wu on 2026/1/16.
//

import Foundation
import Security

struct KeychainService {
    enum KeychainError: Error {
        case unexpectedData
        case unhandled(OSStatus)
    }

    private let service = "com.withmino.Statio.asc"

    func saveCredentials(_ credentials: AppStoreConnectCredentials) throws {
        try saveString(credentials.issuerID, account: "issuerID")
        try saveString(credentials.keyID, account: "keyID")
        try saveString(credentials.privateKey, account: "privateKey")
    }

    func loadCredentials() throws -> AppStoreConnectCredentials? {
        guard let issuerID = try loadString(account: "issuerID"),
              let keyID = try loadString(account: "keyID"),
              let privateKey = try loadString(account: "privateKey") else {
            return nil
        }
        return AppStoreConnectCredentials(issuerID: issuerID, keyID: keyID, privateKey: privateKey)
    }

    func deleteCredentials() throws {
        try deleteItem(account: "issuerID")
        try deleteItem(account: "keyID")
        try deleteItem(account: "privateKey")
    }

    private func saveString(_ value: String, account: String) throws {
        let data = Data(value.utf8)
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
            kSecValueData: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecDuplicateItem {
            let attributes: [CFString: Any] = [kSecValueData: data]
            let updateStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            guard updateStatus == errSecSuccess else {
                throw KeychainError.unhandled(updateStatus)
            }
        } else if status != errSecSuccess {
            throw KeychainError.unhandled(status)
        }
    }

    private func loadString(account: String) throws -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecItemNotFound {
            return nil
        }
        guard status == errSecSuccess else {
            throw KeychainError.unhandled(status)
        }
        guard let data = item as? Data,
              let value = String(data: data, encoding: .utf8) else {
            throw KeychainError.unexpectedData
        }
        return value
    }

    private func deleteItem(account: String) throws {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unhandled(status)
        }
    }
}
