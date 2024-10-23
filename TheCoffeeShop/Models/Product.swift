//
//  Product.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: UUID
    var name: String
    var image: String
    var price: Double
    var sizes: [Size]
    var productDescription: String
    var rating: Double
    var toppings: [String]
    var isFavourite: Bool
    var category: ProductCategory
}

struct ProductCategory: Codable, Hashable {
    let imageUrl: String
    let title: String
}

enum Size: String, Codable {
    case small
    case medium
    case large
    
    var displayText: String {
        switch self {
        case .small:
            "S"
        case .medium:
            "M"
        case .large:
            "L"
        }
    }
    
    var label: String {
        switch self {
        case .small:
            "Small"
        case .medium:
            "Medium"
        case .large:
            "Large"
        }
    }
}

enum PaymentMethod: String, Codable {
    case applePay
    case visaOrMastercard
    case cash
    
    var displayText: String {
        switch self {
        case .applePay:
            "Apple Pay"
        case .visaOrMastercard:
            "Visa/Mastercard"
        case .cash:
            "Cash"
        }
    }
    
    var image: String {
        switch self {
        case .applePay:
            "applepay"
        case .visaOrMastercard:
            "creditcard"
        case .cash:
            "cash"
        }
    }
}
