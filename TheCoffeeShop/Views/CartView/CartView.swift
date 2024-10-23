//
//  CartView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartEnvironment: CartEnvironment
    @EnvironmentObject var router: Router
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
                
                if !viewModel.cartItems.isEmpty {
                    Text("YOUR ORDERS:")
                        .font(.headline)
                        .bold()
                        .padding(.horizontal)
                    
                    ScrollView {
                        ForEach($viewModel.cartItems, id: \.product.id) { item in
                            ListItemView(
                                cartItem: item,
                                increaseItemQuantity: { item in
                                    viewModel.increaseItemQuantity(item, cartEnvironment)
                                },
                                decreseItemQuantity: { item in
                                    viewModel.decreaseItemQuantity(item, cartEnvironment)
                                },
                                showQuantityOption: true,
                                showFavouriteButton: false
                            )
                            .onTapGesture {
                                router.push(.productDetail(item.wrappedValue))
                            }
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Text("Total: \(String(format: "%.2f$", viewModel.totalPrice))")
                            .font(.headline)
                            .bold()
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        router.push(.createOrderView(viewModel.cartItems))
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
                } else {
                    Spacer()
                    VStack(alignment: .center) {
                        Text("Empty")
                            .font(.largeTitle)
                        Text("Add item to make an order")
                            .font(.title2)
                    }
                    .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetchCartItems(cartEnvironment)
        })
        .padding()
    }
}

#Preview {
    CartView()
        .environmentObject(Router())
        .environmentObject(CartEnvironment())
}
