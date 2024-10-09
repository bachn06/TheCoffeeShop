//
//  ItemDetailView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 30/9/24.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedSize: String = "Small"
    @State private var selectedToppings: [String: Int] = ["Caramel": 0, "Banana": 0, "Chocolate": 1, "Strawberry": 0]
    
    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geometry in
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .foregroundStyle(.red)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height / 2)
                }
                .ignoresSafeArea()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(.leading, 20)
            }

            // Coffee size selection
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text("Cappuccino")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding()
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.white)
                        Text("4.9")
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
                
                VStack {
                    VStack(alignment: .leading, spacing: 15) {
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
                    
                    // About section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About")
                            .font(.headline)
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id ipsum vivamus velit lorem amet.")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.body)
                    }
                    .padding(.top)
                    
                    // Add Toppings
                    VStack(alignment: .leading) {
                        Text("Add Topping(1$)")
                            .font(.headline)
                            .padding(.top)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(selectedToppings.keys.sorted(), id: \.self) { topping in
                                VStack {
                                    HStack {
                                        Text("\(topping)")
                                        Spacer()
                                        Button(action: {
                                            if selectedToppings[topping]! > 0 {
                                                selectedToppings[topping]! -= 1
                                            }
                                        }) {
                                            Text("-")
                                                .frame(width: 22, height: 22)
                                                .foregroundStyle(.white)
                                                .background(Color(hex: "#CB8A58"))
                                                .clipShape(Circle())
                                        }
                                        
                                        Text("\(selectedToppings[topping]!)")
                                            .frame(width: 30, height: 30)
                                        
                                        Button(action: {
                                            selectedToppings[topping]! += 1
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
                        }
                        .frame(maxHeight: 200)
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
                        Text("4$")
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
                        
                    }
                }
                .padding(.horizontal, 20)
                .background()
                .cornerRadius(30)
            }
        }
    }
}

#Preview {
    ItemDetailView()
}
