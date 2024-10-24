//
//  CartEnvironment.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 21/10/24.
//

import Foundation

final class CartEnvironment: ObservableObject {
    @Published var cartId: UUID = UUID()
    @Published var cartItems: [CartItem] = [] {
        didSet {
            scheduleUpdateCart()
        }
    }
    @Published var paymentMethod: PaymentMethod = .applePay
    @Published var totalPrice: String = ""
    
    private var debounceWorkItem: DispatchWorkItem?
    
    func scheduleUpdateCart() {
        debounceWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            APIService.shared.updateCart(cart: Cart(id: self.cartId, cartItems: cartItems, paymentMethod: .applePay)) { _ in }
        }
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
    
    func updateCart(_ cart: Cart) {
        cartId = cart.id ?? UUID()
        cartItems = cart.cartItems
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
