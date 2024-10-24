//
//  CreateOrderViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 23/10/24.
//

import Foundation

final class CreateOrderViewModel: ObservableObject {
    @Published var cartItems: [CartItem] {
        didSet {
            updatePrice()
        }
    }
    @Published var totalPrice: Double = 0
    
    init(cartItems: [CartItem]) {
        self.cartItems = cartItems
    }
    
    func getAddress(_ userEnvironment: UserEnvironment) {
        userEnvironment.checkLocationServices()
    }
    
    func createOrder(_ cartEnvironment: CartEnvironment, _ router: Router) {
        cartEnvironment.cartItems = []
        router.push(.orderConfimationView)
    }
    
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
}
