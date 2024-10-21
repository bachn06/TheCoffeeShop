//
//  GridItemView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct GridItemView: View {
    @Binding var product: Product
    let toggleFavourite: (Product) -> Void
    let addToCart: (Product) -> Void
    @State var selectedSize: Size?
    @State var price: Double = 0

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                AsyncCachedImage(url: URL(string: product.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 150)
                
                HStack {
                    Spacer()
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
            .padding(.init(top: 5, leading: 5, bottom: 0, trailing: 5))
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(product.name)
                            .font(.headline)
                            .foregroundColor(.black)
                            .lineLimit(1)
                            .padding(.horizontal, 10)
                        
                        let sizes = product.sizes
                        if !sizes.isEmpty {
                            HStack {
                                ForEach(sizes, id: \.self) { size in
                                    if !size.displayText.isEmpty {
                                        Button(action: {
                                            selectedSize = size
                                        }) {
                                            Text(size.displayText)
                                                .font(.system(size: 6))
                                                .padding(5)
                                                .background(selectedSize == size ? Color.brown : Color.gray.opacity(0.2))
                                                .foregroundColor(selectedSize == size ? .white : .black)
                                                .cornerRadius(5)
                                        }
                                        .frame(width: 24, height: 10)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
                HStack {
                    Text(String(format: "%.2f$", product.price))
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        addToCart(product)
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
        .shadow(radius: 5)
        .padding()
    }
}

#Preview {
    GridItemView(
        product: .constant(
            Product(
                id: UUID(),
                name: "Coffee",
                image: "",
                price: 5.45,
                sizes: [],
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
        addToCart: {_ in },
        selectedSize: nil
    )
}
