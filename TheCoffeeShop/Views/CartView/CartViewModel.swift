//
//  CartViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNX8.WDC on 22/10/24.
//

import Foundation

final class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = [] {
        didSet {
            updatePrice()
        }
    }
    @Published var totalPrice: Double = 0
    
    func updatePrice() {
        var totalPrice: Double = 0
        for item in cartItems {
            totalPrice += item.price * Double(item.quantity)
        }
        self.totalPrice = totalPrice
    }
    
    func increaseItemQuantity(_ cartItem: CartItem, _ cartEnvironment: CartEnvironment) {
        if let index = cartItems.firstIndex(where: { $0.product.id == cartItem.product.id }), cartItems[index].quantity < 99 {
            cartItems[index].quantity += 1
        }
        cartEnvironment.cartItems = cartItems
    }
    
    func decreaseItemQuantity(_ cartItem: CartItem, _ cartEnvironment: CartEnvironment) {
        if let index = cartItems.firstIndex(where: { $0.product.id == cartItem.product.id }) {
            if cartItems[index].quantity == 1 {
                cartItems.removeAll(where: { $0.product.id == cartItem.product.id })
            } else {
                cartItems[index].quantity -= 1
            }
        }
        cartEnvironment.cartItems = cartItems
    }
    
    func fetchCartItems(_ cartEnvironment: CartEnvironment) {
        cartItems = cartEnvironment.cartItems
    }
}
