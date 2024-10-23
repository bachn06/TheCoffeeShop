//
//  SplashViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import Foundation

final class SplashViewModel: ObservableObject {
    func fetchProducts(_ userEnvironment: UserEnvironment, completion: @escaping () -> Void) {
        APIService.shared.fetchProducts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.handleProductResponse(products, userEnvironment)
                    completion()
                case .failure(let failure):
                    break
                }
            }
        }
    }
    
    func handleProductResponse(_ products: [Product], _ userEnvironment: UserEnvironment) {
        userEnvironment.products = products
        userEnvironment.favouriteProducts = products.filter({ $0.isFavourite })
    }
}
