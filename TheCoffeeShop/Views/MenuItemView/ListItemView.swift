//
//  ListItemView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct ListItemView: View {
    @Binding var cartItem: CartItem
    var toggleFavourite: ((CartItem) -> Void)?
    var addToCart: ((CartItem) -> Void)?
    var increaseItemQuantity: ((CartItem) -> Void)?
    var decreseItemQuantity: ((CartItem) -> Void)?
    var showQuantityOption: Bool = true
    var showFavouriteButton: Bool = true
    
    var body: some View {
        HStack {
            AsyncCachedImage(url: URL(string: cartItem.product.image), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 94, height: 63)
                    .cornerRadius(14)
            }) {
                ProgressView()
                    .frame(width: 94, height: 63)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(cartItem.product.name)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(1)
                Text(String(format: "%.2f$", cartItem.price))
                    .font(.subheadline)
                    .foregroundColor(.black)
                if showFavouriteButton {
                    Button(action: {
                        toggleFavourite?(cartItem)
                    }) {
                        Image(systemName: cartItem.product.isFavourite ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(cartItem.product.isFavourite ? .red : .gray)
                            .frame(width: 24, height: 24)
                            .padding(8)
                    }
                } else {
                    Spacer()
                }
            }

            Spacer()

            VStack(alignment: .trailing) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.gray)
                    Text("\(cartItem.product.rating, specifier: "%.1f")")
                        .foregroundColor(.gray)
                }
                
                if showQuantityOption {
                    HStack {
                        Button(action: {
                            decreseItemQuantity?(cartItem)
                        }) {
                            Text("-")
                                .frame(width: 22, height: 22)
                                .foregroundStyle(.white)
                                .background(.black)
                                .clipShape(Circle())
                        }
                        
                        Text("\(cartItem.quantity)")
                            .frame(width: 30, height: 30)
                        
                        Button(action: {
                            increaseItemQuantity?(cartItem)
                        }) {
                            Text("+")
                                .frame(width: 22, height: 22)
                                .foregroundStyle(.white)
                                .background(.black)
                                .clipShape(Circle())
                        }
                    }
                } else {
                    Button(action: {
                        addToCart?(cartItem)
                    }) {
                        Text("+")
                            .frame(width: 40, height: 40)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(24)
        .shadow(radius: 1)
        .padding()
    }
}

#Preview {
    ListItemView(
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
        addToCart: {_ in },
        increaseItemQuantity: {_ in },
        decreseItemQuantity: {_ in }
    )
}
