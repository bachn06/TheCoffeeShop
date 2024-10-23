//
//  Cart.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 21/10/24.
//

import Foundation

struct Cart: Codable {
    var cartItems: [CartItem]?
    var paymentMethod: PaymentMethod
}

struct CartItem: Codable {
    var product: Product
    var size: Size?
    var price: Double
    var quantity: Int
    var toppings: [Topping]
}

struct Topping: Codable {
    var topping: String
    var quantity: Int
}
