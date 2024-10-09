//
//  HomeView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

let menuItems = [
    MenuItem(name: "Cappuccino", price: "3$", imageName: "cappuccino"),
    MenuItem(name: "Espresso", price: "2$", imageName: "espresso"),
    MenuItem(name: "Americano", price: "2.55$", imageName: "americano"),
    MenuItem(name: "Latte", price: "4$", imageName: "latte")
]

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Address and contact info
                NavigationLink(
                    destination: MapView()
                ) {
                    AddressAndContactView()
                        .background()
                        .padding(.horizontal, 10)
                }
                
                // Search Bar
                SearchView()
                    .padding(.horizontal, 10)
                
                // Categories
                CategoriesView()
                    .scaledToFit()
                    .padding(.horizontal, 10)
                
                // Menu Items
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
                        ForEach(menuItems, id: \.id) { item in
                            GridItemView(menuItem: item)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    HomeView()
}
