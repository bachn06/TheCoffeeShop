//
// User.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var name: String
    var avatar: String
    var phone: String
    var address: String
}
