//
//  CartEnvironment.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 21/10/24.
//

import Foundation

final class CartEnvironment: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var paymentMethod: PaymentMethod = .applePay
    @Published var totalPrice: String = ""
    
    private var debounceWorkItem: DispatchWorkItem?
    
    func updateCart() {
        
    }
    
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
}

extension CartItem {
    static func ==(lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.product.id == rhs.product.id && lhs.price == rhs.price
    }
}
