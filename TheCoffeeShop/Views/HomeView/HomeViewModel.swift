//
//  HomeViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var products: [CartItem] = []
    @Published var filteredProducts: [CartItem] = []
    @Published var categories: [ProductCategory] = []
    
    @Published var selectedCategories: Set<ProductCategory> = [] {
        didSet {
            debounceFilter()
        }
    }
    
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
        if selectedCategories.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { selectedCategories.contains($0.product.category) }
        }
        
        if !productSearchText.isEmpty {
            filteredProducts = filteredProducts.filter { $0.product.name.lowercased().contains(productSearchText.lowercased()) }
        }
    }
    
    func fetchProducts(_ userEnvironment: UserEnvironment) {
        products = userEnvironment.products.compactMap({ CartItem(product: $0, size: $0.sizes.first, price: $0.price, quantity: 1, toppings: []) })
        getProductCategories(userEnvironment.products)
        filterProducts()
    }
    
    func getProductCategories(_ products: [Product]) {
        for product in products {
            let category = product.category
            if !categories.contains(category) {
                categories.append(category)
            }
        }
    }
    
    func toggleCategory(category: ProductCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
    
    func addToCart(_ cartItem: CartItem, _ cartEnvironment: CartEnvironment) {
        cartEnvironment.addToCart(item: cartItem)
    }
    
    func toggleFavourite(_ cartItem: CartItem, _ userEnvironment: UserEnvironment) {
        userEnvironment.toggleFavourite(cartItem.product)
        fetchProducts(userEnvironment)
    }
}
