//
//  ListItemView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct ListItemView: View {
    @State private var quantity: Int = 0
    @State var isLiked = false
    var showQuantityOption = true
    var showFavouriteButton = true
    
    var body: some View {
        HStack {
            Image(systemName: "leaf.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 94, height: 63)
                .cornerRadius(14)

            VStack(alignment: .leading, spacing: 5) {
                Text("Bun cha")
                    .font(.headline)
                    .foregroundColor(.black)
                Text("2$")
                    .font(.subheadline)
                    .foregroundColor(.black)
                if showFavouriteButton {
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
            }

            Spacer()

            VStack(alignment: .trailing) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.gray)
                    Text("\(4.8, specifier: "%.1f")")
                        .foregroundColor(.gray)
                }
                
                if showQuantityOption {
                    HStack {
                        Button(action: {
                            if quantity > 0 {
                                quantity -= 1
                            }
                        }) {
                            Text("-")
                                .frame(width: 22, height: 22)
                                .foregroundStyle(.white)
                                .background(.black)
                                .clipShape(Circle())
                        }
                        
                        Text("\(quantity)")
                            .frame(width: 30, height: 30)
                        
                        Button(action: {
                            quantity += 1
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
    ListItemView()
}
