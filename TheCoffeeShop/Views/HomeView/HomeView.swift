//
//  HomeView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var cartEnvironment: CartEnvironment
    @EnvironmentObject var locationEnvironment: LocationEnvironment
    @EnvironmentObject var userEnvironment: UserEnvironment
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(
                destination: MapView()
            ) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(locationEnvironment.address)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "phone.fill")
                }
                .foregroundStyle(.black)
            }
            .padding(.horizontal, 25)
            
            // Search Bar
            SearchView(searchText: $viewModel.productSearchText)
                .padding(.horizontal, 10)
            
            // Categories
            if !viewModel.categories.isEmpty {
                CategoriesView(
                    categories: viewModel.categories,
                    selectedCategories: $viewModel.selectedCategories
                ) { category in
                    viewModel.toggleCategory(category: category)
                }
                .scaledToFit()
                .padding(.horizontal, 10)
            }
            
            // Menu Items
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
                    ForEach($viewModel.filteredProducts, id: \.product.id) { item in
                        NavigationLink {
                            ItemDetailView(cartItem: item)
                        } label: {
                            GridItemView(cartItem: item, toggleFavourite: { cartItem in
                                viewModel.toggleFavourite(cartItem, userEnvironment)
                            }, addToCart: { cartItem in
                                viewModel.addToCart(cartItem, cartEnvironment)
                            })
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .onAppear {
            viewModel.fetchProducts(userEnvironment)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserEnvironment())
        .environmentObject(LocationEnvironment())
        .environmentObject(CartEnvironment())
}
