//
//  Cart.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 21/10/24.
//

import Foundation

struct Cart: Codable {
    var products: [Product]?
    var paymentMethod: PaymentMethod
}

struct CartItem: Codable {
    var product: Product
    var price: Double
    var quantity: Int
    var toppings: [String]
}
