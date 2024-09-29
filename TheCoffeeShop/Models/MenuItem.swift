//
//  MenuItem.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import Foundation

struct MenuItem: Identifiable {
    let id = UUID()
    let name: String
    let price: String
    let imageName: String
}
