//
//  FavouriteView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject var cartEnvironment: CartEnvironment
    @EnvironmentObject var userEnvironment: UserEnvironment
    @StateObject var viewModel: FavouriteViewModel = FavouriteViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                SearchView(searchText: $viewModel.productSearchText)
                    .padding(.horizontal, 10)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                        ForEach($viewModel.filteredProducts, id: \.id) { item in
                            ListItemView(product: item, toggleFavourite: { product in
                                viewModel.toggleFavourite(product)
                            }, addToCart: { product in
                                viewModel.addToCart(product)
                            }, showQuantityOption: false)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewModel.fetchFavouriteProduct(userEnvironment)
        }
    }
}

#Preview {
    FavouriteView()
        .environmentObject(UserEnvironment())
        .environmentObject(CartEnvironment())
}
