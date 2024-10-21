//
//  CartEnvironment.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 21/10/24.
//

import Foundation

final class CartEnvironment: ObservableObject {
    @Published var cartItems: [CartItem] = [] {
        didSet {
            totalItem = cartItems.count
            updateTotalPrice()
        }
    }
    @Published var totalItem: Int = 0
    @Published var paymentMethod: PaymentMethod = .applePay
    @Published var totalPrice: String = ""
    
    func addToCart(item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0 == item }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(item)
        }
    }
    
    func removeItemFromCart(item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0 == item }) {
            if cartItems[index].quantity == 1 {
                cartItems.remove(at: index)
            } else {
                cartItems[index].quantity -= 1
            }
        }
    }
    
    func updateTotalPrice() {
        let price = cartItems.reduce(0) {
            $0 + $1.price * Double($1.quantity)
        }
        totalPrice = String(format: "%.2f$", price)
    }
}

extension CartItem {
    static func ==(lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.product.id == rhs.product.id && lhs.toppings == rhs.toppings && lhs.price == rhs.price
    }
}
