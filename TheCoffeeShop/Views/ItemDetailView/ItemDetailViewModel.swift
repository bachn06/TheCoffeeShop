//
//  ItemDetailViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNX8.WDC on 23/10/24.
//

import Foundation

final class ItemDetailViewModel: ObservableObject {
    struct Topping {
        var name: String
        var quantity: Int
    }
    
    @Published var cartItem: CartItem
    @Published var toppings: [Topping] = [] {
        didSet {
            updatePrice()
        }
    }
    @Published var totalPrice: Double = 0
    
    init(cartItem: CartItem) {
        self.cartItem = cartItem
        prepareData()
    }
    
    private var basePrice: Double = 0
    
    func updatePrice() {
        var toppingPrice = 0.0
        for topping in toppings {
            toppingPrice += Double(topping.quantity)
        }
        totalPrice = basePrice + toppingPrice
    }
    
    func prepareData() {
        toppings = cartItem.product.toppings.compactMap({ Topping(name: $0, quantity: 0) })
        basePrice = cartItem.price
        updatePrice()
    }
    
    func increseTopping(_ topping: String) {
        if let index = toppings.firstIndex(where: { $0.name == topping }), toppings[index].quantity < 99 {
            toppings[index].quantity += 1
        }
    }
    
    func decreaseTopping(_ topping: String) {
        if let index = toppings.firstIndex(where: { $0.name == topping }), toppings[index].quantity > 0 {
            toppings[index].quantity -= 1
        }
    }
    
    func toggleFavourite(_ product: Product, _ userEnvironment: UserEnvironment) {
        self.cartItem.product.isFavourite.toggle()
        userEnvironment.toggleFavourite(product)
    }
    
    func addToCart(_ cartItem: CartItem, _ cartEnvironment: CartEnvironment) {
        var cartItem = cartItem
        cartItem.price = totalPrice
        cartEnvironment.addToCart(item: cartItem)
    }
}
