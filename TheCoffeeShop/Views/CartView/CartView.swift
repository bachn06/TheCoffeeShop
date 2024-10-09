//
//  CartView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct CartView: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image(systemName: "box.truck.fill")
                        .padding(10)
                        .foregroundStyle(.brown)
                }
                .padding(.horizontal)
                
                Text("YOUR ORDERS:")
                    .font(.headline)
                    .bold()
                    .padding(.horizontal)
                
                ScrollView {
                    ForEach(menuItems, id: \.id) { item in
                        ListItemView(showQuantityOption: true, showFavouriteButton: false)
                    }
                }
                .frame(maxHeight: geometry.size.height / 1.5)
                
                HStack {
                    Spacer()
                    Text("Total: 14$")
                        .font(.headline)
                        .bold()
                }
                .padding()
                
                Button(action: {
                    
                }) {
                    HStack {
                        Text("Go to Cart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .cornerRadius(16)
                    .padding(.horizontal, 20)
                }
            }
        }
        .padding()
    }
}

#Preview {
    CartView()
}
