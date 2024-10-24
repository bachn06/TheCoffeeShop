//
//  ItemDetailView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 30/9/24.
//

import SwiftUI

struct ItemDetailView: View {
    @EnvironmentObject var userEnvironment: UserEnvironment
    @EnvironmentObject var cartEnvironment: CartEnvironment
    @EnvironmentObject var router: Router
    @StateObject var viewModel: ItemDetailViewModel
    
    init(cartItem: CartItem) {
        _viewModel = StateObject(wrappedValue: ItemDetailViewModel(cartItem: cartItem))
    }

    @State private var contentSize: CGSize = .zero
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geometry in
                    AsyncCachedImage(url: URL(string: viewModel.cartItem.product.image)) { image in
                        image
                            .resizable()
                            .foregroundStyle(.red)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height / 1.8)
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: geometry.size.height / 1.8)
                            .background(.gray)
                    }
                }
                .ignoresSafeArea()
                
                HStack {
                    Button(action: {
                        router.popView()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleFavourite(viewModel.cartItem.product, userEnvironment)
                    }) {
                        Image(systemName: viewModel.cartItem.product.isFavourite ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(viewModel.cartItem.product.isFavourite ? .red : .gray)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal)
            }

            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text(viewModel.cartItem.product.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.white)
                        Text(String(format: "%.1f", viewModel.cartItem.product.rating))
                            .foregroundStyle(.white)
                            .font(.subheadline)
                    }
                    .padding(10)
                    .background {
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(Color(hex: "#846046"))
                    }
                    .padding(.trailing, 10)
                }
                .background {
                    Rectangle()
                        .frame(height: 90)
                        .foregroundStyle(Color(hex: "#000000", opacity: 0.3))
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading) {
                    let sizes = viewModel.cartItem.product.sizes
                    if !sizes.isEmpty {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Select Size")
                                .font(.headline)
                                .padding(.top)
                            
                            HStack {
                                ForEach(sizes, id: \.self) { size in
                                    Button(action: {
                                        viewModel.cartItem.size = size
                                    }) {
                                        Text(size.label)
                                            .font(.subheadline)
                                            .frame(width: 90)
                                            .padding()
                                            .background(viewModel.cartItem.size == size ? Color(hex: "#846046") : Color.white)
                                            .foregroundStyle(viewModel.cartItem.size == size ? Color.white : Color.black)
                                            .cornerRadius(36)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 36)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundColor(.gray)
                                            }
                                    }
                                }
                            }
                        }
                    }
                    
                    // About section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About")
                            .font(.headline)
                        
                        Text(viewModel.cartItem.product.productDescription)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.body)
                            .lineLimit(6)
                    }
                    .padding(.top)
                    
                    // Add Toppings
                    if !viewModel.toppings.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Add Topping(1$)")
                                .font(.headline)
                                .padding(.top)
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(viewModel.toppings, id: \.name) { topping in
                                    VStack {
                                        HStack {
                                            Text("\(topping.name)")
                                            Spacer()
                                            Button(action: {
                                                viewModel.decreaseTopping(topping.name)
                                            }) {
                                                Text("-")
                                                    .frame(width: 22, height: 22)
                                                    .foregroundStyle(.white)
                                                    .background(Color(hex: "#CB8A58"))
                                                    .clipShape(Circle())
                                            }
                                            
                                            Text("\(topping.quantity)")
                                                .frame(width: 30, height: 30)
                                            
                                            Button(action: {
                                                viewModel.increseTopping(topping.name)
                                            }) {
                                                Text("+")
                                                    .frame(width: 22, height: 22)
                                                    .foregroundStyle(.white)
                                                    .background(Color(hex: "#CB8A58"))
                                                    .clipShape(Circle())
                                            }
                                        }
                                        Rectangle()
                                            .frame(maxWidth: .infinity, maxHeight: 0.5)
                                            .background(.black)
                                    }
                                }
                                .padding(5)
                                .overlay(
                                    GeometryReader { geo in
                                        Color.clear.onAppear {
                                            contentSize = geo.size
                                        }
                                    }
                                )
                            }
                            .frame(maxHeight: min(contentSize.height > 150 ? contentSize.height : 150, 300))
                        }
                    } else {
                        Spacer()
                            .frame(height: 250)
                    }
                    
                    // Add to Cart Button
                    HStack {
                        Text("Add to Cart")
                            .foregroundStyle(.white)
                            .padding()
                            .cornerRadius(10)
                        Rectangle()
                            .frame(width: 1)
                            .foregroundStyle(.white)
                            .padding()
                        Text(String(format: "%.2f$", viewModel.totalPrice))
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .background(.black)
                    .cornerRadius(45)
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        viewModel.addToCart(viewModel.cartItem, cartEnvironment)
                        router.popView()
                    }
                }
                .padding(.horizontal, 20)
                .background()
                .cornerRadius(30)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ItemDetailView(
        cartItem: (
            CartItem(
                id: UUID(),
                product: Product(
                id: UUID(),
                name: "Coffee",
                image: "",
                price: 5.45,
                sizes: [.small, .medium],
                productDescription: "A great coffee",
                rating: 5,
                toppings: [],
                isFavourite: false,
                category: ProductCategory(
                    imageUrl: "https://picsum.photos/id/12/2500/1667",
                    title: "Coffee")
                ),
                size: Size.small,
                price: 0,
                quantity: 0,
                toppings: []
            )
        )
    )
    .environmentObject(Router())
    .environmentObject(UserEnvironment())
    .environmentObject(CartEnvironment())
}
