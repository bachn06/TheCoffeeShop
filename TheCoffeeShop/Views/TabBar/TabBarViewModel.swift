//
//  TabBarViewModel.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import SwiftUI

final class TabBarViewModel: ObservableObject {
    func getProfileImageURL(_ userEnvironment: UserEnvironment) -> String {
        userEnvironment.imageUrl
    }
    
    func getBadge(_ cartEnvironment: CartEnvironment) -> Int? {
        cartEnvironment.cartItems.isEmpty ? nil : cartEnvironment.cartItems.count
    }
}
