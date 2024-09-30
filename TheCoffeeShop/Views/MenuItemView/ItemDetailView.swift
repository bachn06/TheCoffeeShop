//
//  ItemDetailView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 30/9/24.
//

import SwiftUI

struct ItemDetailView: View {
    @State private var selectedSize: String = "Small"
    @State private var selectedToppings: [String: Int] = ["Caramel": 0, "Banana": 0, "Chocolate": 1, "Strawberry": 0]
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .overlay(
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Cappuccino")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text("4.9")
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                }
                                .padding(.leading)
                            }
                            Spacer()
                        }
                        .padding(.top, 100)
                    )
                    .cornerRadius(20)
                
                Button(action: {
                    
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding()
            }
            .frame(height: 300)

            // Coffee size selection
            VStack(alignment: .leading) {
                Text("Coffee Size")
                    .font(.headline)
                    .padding(.top)
                
                HStack {
                    ForEach(["Small", "Medium", "Large"], id: \.self) { size in
                        Button(action: {
                            selectedSize = size
                        }) {
                            Text(size)
                                .font(.subheadline)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(selectedSize == size ? Color.brown : Color.gray.opacity(0.2))
                                .foregroundColor(selectedSize == size ? Color.white : Color.black)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.top, 10)
                
                // About section
                Text("About")
                    .font(.headline)
                    .padding(.top)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id ipsum vivamus velit lorem amet.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                
                // Add Toppings
                Text("Add Topping(1$)")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(selectedToppings.keys.sorted(), id: \.self) { topping in
                    HStack {
                        Text(topping)
                        Spacer()
                        Button(action: {
                            if selectedToppings[topping]! > 0 {
                                selectedToppings[topping]! -= 1
                            }
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.gray)
                        }
                        Text("\(selectedToppings[topping]!)")
                        Button(action: {
                            selectedToppings[topping]! += 1
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.brown)
                        }
                    }
                    .padding(.vertical, 5)
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
                        .padding(.init(top: 25, leading: 0, bottom: 25, trailing: 0))
                    Text("4$")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding()
                }
                .frame(maxWidth: .infinity)
                .background(.black)
                .cornerRadius(45)
                .padding(.horizontal, 20)
                .onTapGesture {
                    
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(30)
            .offset(y: -30) // Lift card up slightly
            .shadow(radius: 10)
            .padding(.horizontal)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    ItemDetailView()
}
