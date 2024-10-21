//
//  FavouriteViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 21/10/24.
//

import Foundation

final class FavouriteViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var filteredProducts: [Product] = []
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
            filteredProducts = filteredProducts.filter { $0.name.lowercased().contains(productSearchText.lowercased()) }
        } else {
            filteredProducts = products
        }
    }
    
    func fetchFavouriteProduct(_ userEnvironment: UserEnvironment) {
        products = userEnvironment.products.filter({ $0.isFavourite })
        filterProducts()
    }
}
