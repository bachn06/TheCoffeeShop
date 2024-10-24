//
//  AccessToken.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 24/10/24.
//

import Foundation

struct LoginRequest: Codable {
    var userName: String
    var phoneNumber: String
}

struct LoginResponse: Codable {
    var userId: UUID?
    var accessToken: AccessToken
}

struct AccessToken: Codable {
    var accessToken: String
    var expireIn: Int
    
    var expirationDate: Date {
        return Date().addingTimeInterval(TimeInterval(expireIn))
    }
}
