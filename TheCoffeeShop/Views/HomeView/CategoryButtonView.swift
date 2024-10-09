//
//  CategoryButtonView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct CategoryButtonView: View {
    let title: String
    let icon: String
    var action: () -> Void
    @State var isSelected: Bool = false

    var body: some View {
        Button(action: {
            action()
            isSelected.toggle()
        }) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 16, height: 16)
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .fixedSize()
                    .foregroundStyle(isSelected ? .white : .black)
            }
            .padding(10)
            .background(
                Group {
                    if isSelected {
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "#CB8A58"), Color(hex: "#562B1A")]), startPoint: .leading, endPoint: .trailing)
                    } else {
                        Color.white
                    }
                }
            )
            .cornerRadius(36)
            .overlay(
                RoundedRectangle(cornerRadius: 36)
                    .stroke(Color.black, lineWidth: 1)
            )
            .frame(minWidth: 0)
            
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#Preview {
    CategoryButtonView(title: "ALCOHOL FREE", icon: "leaf.fill", action: {})
}
