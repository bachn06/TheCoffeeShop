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
    @EnvironmentObject var router: Router
    @StateObject var viewModel: FavouriteViewModel = FavouriteViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                SearchView(searchText: $viewModel.productSearchText)
                    .padding(.horizontal, 10)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                        ForEach($viewModel.filteredProducts, id: \.product.id) { item in
                            ListItemView(
                                cartItem: item,
                                toggleFavourite: { item in
                                    viewModel.toggleFavourite(item, userEnvironment)
                                },
                                addToCart: { item in
                                    viewModel.addToCart(item, cartEnvironment)
                                },
                                showQuantityOption: false)
                            .onTapGesture {
                                router.push(.productDetail(item.wrappedValue))
                            }
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
        .environmentObject(Router())
}
