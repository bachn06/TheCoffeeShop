//
//  CartView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var userEnvironment: UserEnvironment
    @EnvironmentObject var cartEnvironment: CartEnvironment
    @StateObject var viewModel: CartViewModel = CartViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("carbon_delivery")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(10)
                }
                .padding(.horizontal)
                
                Text("YOUR ORDERS:")
                    .font(.headline)
                    .bold()
                    .padding(.horizontal)
                
                ScrollView {
                    ForEach($viewModel.cartItems, id: \.product.id) { item in
                        ListItemView(
                            product: item.product,
                            toggleFavourite: { _ in },
                            addToCart: { _ in },
                            showQuantityOption: true,
                            showFavouriteButton: false
                        )
                    }
                }
                
                HStack {
                    Spacer()
                    Text("Total: \(String(format: "%.1f$", viewModel.totalPrice))")
                        .font(.headline)
                        .bold()
                }
                .padding()
                
                Spacer()
                
                NavigationLink {
                    CreateOrderView(cartItems: $viewModel.cartItems) {
                        
                    }
                } label: {
                    HStack {
                        Text("Go to Cart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(16)
                    .padding(.horizontal, 20)
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetchCartItems(userEnvironment)
        })
        .padding()
    }
}

#Preview {
    CartView()
        .environmentObject(UserEnvironment())
        .environmentObject(CartEnvironment())
}
