//
//  UserEnvironment.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import Foundation

final class UserEnvironment: ObservableObject {
    @Published var userName: String = ""
    @Published var phoneNumber: String = ""
    @Published var address: String = ""
    @Published var products: [Product] = []
    @Published var categories: [ProductCategory] = []
    @Published var favouriteProducts: [Product] = []
    @Published var cartItems: [CartItem] = []
}

