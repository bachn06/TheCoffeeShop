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

struct Orders: Codable {
    var orders: [Order]
}

struct Order: Codable {
    var status: OrderStatus
    var timeStamp: String
    var quantity: Int
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
