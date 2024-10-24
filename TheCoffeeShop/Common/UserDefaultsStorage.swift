//
//  UserDefaultsStorage.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 25/10/24.
//

import Foundation

final class UserDefaultsStorage {
    static let shared = UserDefaultsStorage()
    
    private let userIdKey = "userId"
    
    private init() {}
    
    func saveUserId(_ userId: String) {
        UserDefaults.standard.set(userId, forKey: userIdKey)
    }
    
    func getUserId() -> String {
        UserDefaults.standard.string(forKey: userIdKey) ?? ""
    }
    
    func removeUserId() {
        UserDefaults.standard.removeObject(forKey: userIdKey)
    }
}
