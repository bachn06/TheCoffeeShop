//
// APIConstants.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import Foundation

struct APIConstants {
    static let baseURL = "http://localhost:8080"
    
    enum apiPath: String {
        case login = "/users/login"
        case profile = "/users"
        case products = "/products"
        case favouriteProducts = "/products/favourites"
        case carts = "/carts"
        case order = "/order"
        case cartItems = "/carts_item"
    }
}
