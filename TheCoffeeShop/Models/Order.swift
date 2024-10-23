//
//  Order.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 24/10/24.
//

import Foundation

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
    var timestamp: Date?
}
