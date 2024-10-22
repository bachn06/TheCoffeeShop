//
//  CartViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNX8.WDC on 22/10/24.
//

import Foundation

final class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var totalPrice: Double = 0
    
    func fetchCartItems(_ userEnvironment: UserEnvironment) {
        cartItems = userEnvironment.cartItems
    }
    
    func removeItemFromCart(_ cartItem: CartItem, _ userEnvironment: UserEnvironment) {
        cartItems.removeAll(where: { $0.product.id == cartItem.product.id })
        userEnvironment.cartItems = cartItems
    }
}