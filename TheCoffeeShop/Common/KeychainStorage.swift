//
//  KeychainStorage.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 25/10/24.
//

import Foundation
import Security

final class UserStorage {
    static let shared = UserStorage()
    
    private init() {}

    @discardableResult
    func saveAccessToken(_ token: AccessToken) -> Bool {
        let data = try! JSONEncoder().encode(token)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken",
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }

    func getAccessToken() -> AccessToken? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            return nil
        }
        
        if let data = item as? Data {
            let token = try? JSONDecoder().decode(AccessToken.self, from: data)
            if let token = token, Date() < token.expirationDate {
                return token
            } else {
                deleteAccessToken()
            }
        }
        
        return nil
    }

    @discardableResult
    func deleteAccessToken() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "accessToken"
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
