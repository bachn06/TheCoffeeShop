//
//  TabBarViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import SwiftUI

final class TabBarViewModel: ObservableObject {
    func fetchProfile(_ userEnvironment: UserEnvironment) {
        APIService.shared.fetchProfile(userId: userEnvironment.userId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    userEnvironment.updateUserInfo(user)
                case .failure:
                    break
                }
            }
        }
    }
    
    func fetchCart(_ cartEnvironment: CartEnvironment) {
        APIService.shared.fetchCart { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    cartEnvironment.updateCart(cart)
                case .failure:
                    break
                }
            }
        }
    }
    
    func getProfileImageURL(_ userEnvironment: UserEnvironment) -> String {
        userEnvironment.imageUrl
    }
    
    func getBadge(_ cartEnvironment: CartEnvironment) -> Int? {
        cartEnvironment.cartItems.isEmpty ? nil : cartEnvironment.cartItems.count
    }
}
