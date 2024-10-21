//
//  ListItemView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct ListItemView: View {
    @Binding var product: Product
    let toggleFavourite: (Product) -> Void
    let addToCart: (Product) -> Void
    var showQuantityOption = true
    var showFavouriteButton = true
    
    var body: some View {
        HStack {
            AsyncCachedImage(url: URL(string: product.image), content: { image in
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
                Text(product.name)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(2)
                Text(String(format: "%.2f$", product.price))
                    .font(.subheadline)
                    .foregroundColor(.black)
                if showFavouriteButton {
                    Button(action: {
                        toggleFavourite(product)
                    }) {
                        Image(systemName: product.isFavourite ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(product.isFavourite ? .red : .gray)
                            .frame(width: 24, height: 24)
                            .padding(8)
                    }
                }
            }

            Spacer()

            VStack(alignment: .trailing) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.gray)
                    Text("\(product.rating, specifier: "%.1f")")
                        .foregroundColor(.gray)
                }
                
                if showQuantityOption {
                    HStack {
                        Button(action: {
                        }) {
                            Text("-")
                                .frame(width: 22, height: 22)
                                .foregroundStyle(.white)
                                .background(.black)
                                .clipShape(Circle())
                        }
                        
                        Text("1")
                            .frame(width: 30, height: 30)
                        
                        Button(action: {
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
                        addToCart(product)
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
    ListItemView(product: .constant(
        Product(
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
        )
    ),
    toggleFavourite: {_ in },
    addToCart: {_ in })
}
