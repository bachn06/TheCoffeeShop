//
//  FavouriteViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 21/10/24.
//

import Foundation

final class FavouriteViewModel: ObservableObject {
    @Published var products: [CartItem] = []
    @Published var filteredProducts: [CartItem] = []
    @Published var productSearchText: String = "" {
        didSet {
            debounceFilter()
        }
    }
    
    private var debounceWorkItem: DispatchWorkItem?
    
    func debounceFilter() {
        debounceWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in
            self?.filterProducts()
        }
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
    }
    
    func filterProducts() {
        if !productSearchText.isEmpty {
            filteredProducts = filteredProducts.filter { $0.product.name.lowercased().contains(productSearchText.lowercased()) }
        } else {
            filteredProducts = products
        }
    }
    
    func fetchFavouriteProduct(_ userEnvironment: UserEnvironment) {
        products = userEnvironment.favouriteProducts.compactMap({
            CartItem(product: $0, price: $0.price, quantity: 1, toppings: [])
        })
        filterProducts()
    }
    
    func toggleFavourite(_ cartItem: CartItem, _ userEnvironment: UserEnvironment) {
        products.removeAll(where: { $0.product.id == cartItem.product.id })
        userEnvironment.toggleFavourite(cartItem.product)
        filterProducts()
    }
    
    func addToCart(_ cartItem: CartItem, _ cartEnvironment: CartEnvironment) {
        cartEnvironment.addToCart(item: cartItem)
    }
}
