//
//  GridItemView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct GridItemView: View {
    let menuItem: MenuItem
    let sizes: [String] = ["S", "M", "L"]
    let price: String = "2$"
    @State private var selectedSize: String = "M"
    @State var isLiked = false

    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .cornerRadius(10)
                    .clipped()
                
                Button(action: {
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(isLiked ? .red : .gray)
                        .frame(width: 24, height: 24)
                        .padding(8)
                }
            }
            .padding(.init(top: 5, leading: 5, bottom: 0, trailing: 5))
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(menuItem.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        HStack {
                            ForEach(sizes, id: \.self) { size in
                                Button(action: {
                                    selectedSize = size
                                }) {
                                    Text(size)
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
                    Spacer()
                }
                HStack {
                    Text(price)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                    }) {
                        Text("+")
                            .frame(width: 40, height: 40)
                            .background(Color.brown)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 5)
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

#Preview {
    GridItemView(menuItem: MenuItem(name: "Cappuccino", price: "3$", imageName: "cappuccino"))
}
