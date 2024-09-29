//
// User.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var avatar: Data?
    var phone: String
    var address: String
    var isLoggedIn: Bool = false
}

struct Product: Codable, Identifiable {
    var id: UUID
    var name: String
    var image: Data?
    var price: String
    var size: Size?
    var productDescription: String
    var rating: Double?
    var topping: [String]?
    var isFavourite: Bool
}

enum Size: String, Codable {
    case small
    case medium
    case large
}

struct Cart: Codable {
    var products: [Product]?
    var paymentMethod: PaymentMethod
}

enum PaymentMethod: String, Codable {
    case applePay
    case visaOrMastercard
    case cash
}

struct Orders: Codable {
    var orders: [Order]
}

struct Order: Codable {
    var status: OrderStatus
    var timeStamp: String
}

enum OrderStatus: String, Codable {
    case confirmed
    case processed
    case delivery
    case completed
    
    func getDisplayValue() -> String {
        switch self {
        case .confirmed:
            return "Order Confirmed"
        case .processed:
            return "Order Processed"
        case .delivery:
            return "On Delivery"
        case .completed:
            return "Order Completed"
        }
    }
}

struct OrderStatusRecord: Codable {
    var id: UUID?
    var status: OrderStatus
    var timestamp: Date
}
