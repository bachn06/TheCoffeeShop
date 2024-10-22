//
//  HomeViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
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
            filteredProducts = products.filter { selectedCategories.contains($0.category) }
        }
        
        if !productSearchText.isEmpty {
            filteredProducts = filteredProducts.filter { $0.name.lowercased().contains(productSearchText.lowercased()) }
        }
    }
    
    func fetchProducts(_ userEnvironment: UserEnvironment) {
        APIService.shared.fetchProducts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.handleProductResponse(products, userEnvironment)
                case .failure(let failure):
                    break
                }
            }
        }
    }
    
    func handleProductResponse(_ products: [Product], _ userEnvironment: UserEnvironment) {
        self.products = products
        userEnvironment.products = products
        getProductCategories(products)
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
    
    func addToCart(product: Product, _ userEnvironment: UserEnvironment) {
        userEnvironment.cartItems.append(CartItem(product: product, price: product.price, quantity: 1, toppings: []))
    }
    
    func toggleFavourite(product: Product) {
        
    }
}
