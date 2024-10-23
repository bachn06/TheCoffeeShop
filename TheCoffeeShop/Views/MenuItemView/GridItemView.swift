//
//  GridItemView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct GridItemView: View {
    @Binding var cartItem: CartItem
    let toggleFavourite: (CartItem) -> Void
    let addToCart: (CartItem) -> Void
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                AsyncCachedImage(url: URL(string: cartItem.product.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        toggleFavourite(cartItem)
                    }) {
                        Image(systemName: cartItem.product.isFavourite ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(cartItem.product.isFavourite ? .red : .gray)
                            .frame(width: 24, height: 24)
                            .padding(8)
                    }
                }
            }
            .padding(5)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(cartItem.product.name)
                            .font(.headline)
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .padding(.horizontal, 10)
                        
                        let sizes = cartItem.product.sizes
                        if !sizes.isEmpty {
                            HStack {
                                ForEach(sizes, id: \.self) { size in
                                    if !size.displayText.isEmpty {
                                        Button(action: {
                                            cartItem.size = size
                                        }) {
                                            Text(size.displayText)
                                                .font(.system(size: 6))
                                                .padding(5)
                                                .frame(width: 24, height: 12)
                                                .background(cartItem.size == size ? Color.brown : Color.gray.opacity(0.2))
                                                .foregroundColor(cartItem.size == size ? .white : .black)
                                                .cornerRadius(10)
                                        }
                                    }
                                }
                            }
                            .padding(.leading, 10)
                        }
                    }
                    Spacer()
                }
                HStack {
                    Text(String(format: "%.2f$", cartItem.product.price))
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        addToCart(cartItem)
                    }) {
                        Text("+")
                            .frame(width: 40, height: 40)
                            .background(Color.brown)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 5)
                .padding(.horizontal, 10)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0.5)
                .foregroundColor(.gray)
        })
        .padding()
    }
}

#Preview {
    GridItemView(
        cartItem: .constant(
            CartItem(
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
        ),
        toggleFavourite: {_ in },
        addToCart: {_ in }
    )
}
