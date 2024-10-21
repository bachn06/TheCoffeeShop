//
//  ItemDetailView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 30/9/24.
//

import SwiftUI

struct ItemDetailView: View {
    @EnvironmentObject var cartEnvironment: CartEnvironment
    @Environment(\.dismiss) private var dismiss
    @Binding var product: Product
    @State var selectedSize: Size?
    let toggleFavourite: (Product) -> Void
    let addToCart: (Product) -> Void
    
    @State private var contentSize: CGSize = .zero
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geometry in
                    AsyncCachedImage(url: URL(string: product.image)) { image in
                        image
                            .resizable()
                            .foregroundStyle(.red)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height / 1.8)
                    } placeholder: {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: geometry.size.height / 1.8)
                    }
                }
                .ignoresSafeArea()
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        toggleFavourite(product)
                    }) {
                        Image(systemName: product.isFavourite ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(product.isFavourite ? .red : .gray)
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal)
            }

            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text(product.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.white)
                        Text(String(format: "%.1f", product.rating))
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
                    let sizes = product.sizes
                    if !sizes.isEmpty {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Select Size")
                                .font(.headline)
                                .padding(.top)
                            
                            HStack {
                                ForEach(sizes, id: \.self) { size in
                                    Button(action: {
                                        selectedSize = size
                                    }) {
                                        Text("\(size)")
                                            .font(.subheadline)
                                            .frame(width: 90)
                                            .padding()
                                            .background(selectedSize == size ? Color(hex: "#846046") : Color.white)
                                            .foregroundStyle(selectedSize == size ? Color.white : Color.black)
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
                        
                        Text(product.productDescription)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.body)
                    }
                    .padding(.top)
                    
                    // Add Toppings
                    let toppings = product.toppings
                    if !toppings.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Add Topping(1$)")
                                .font(.headline)
                                .padding(.top)
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(toppings, id: \.self) { topping in
                                    VStack {
                                        HStack {
                                            Text("\(topping)")
                                            Spacer()
                                            Button(action: {
                                                
                                            }) {
                                                Text("-")
                                                    .frame(width: 22, height: 22)
                                                    .foregroundStyle(.white)
                                                    .background(Color(hex: "#CB8A58"))
                                                    .clipShape(Circle())
                                            }
                                            
                                            Text("1")
                                                .frame(width: 30, height: 30)
                                            
                                            Button(action: {
                                                
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
                            .frame(maxHeight: min(contentSize.height, 300))
                        }
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
                        Text(String(format: "%.2f$", product.price))
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
                        addToCart(product)
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
    ItemDetailView(product: .constant(Product(
        id: UUID(),
        name: "Coffee",
        image: "https://picsum.photos/id/12/2500/1667",
        price: 5.45,
        sizes: [.large, .medium, .small],
        productDescription: "A great coffee",
        rating: 4,
        toppings: ["Banana", "Soda", "Object", "Chocolate"],
        isFavourite: false,
        category: ProductCategory(
            imageUrl: "https://picsum.photos/id/12/2500/1667",
            title: "Coffee")
    )), toggleFavourite: { _ in }, addToCart: { _ in }
    )
    .environmentObject(CartEnvironment())
}
