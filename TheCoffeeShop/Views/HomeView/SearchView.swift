//
//  SearchView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search ..", text: $searchText)
                    .padding(.leading, 5)
            }
            .padding(.horizontal)
            .frame(height: 50)
            .background(Color(.systemGray6))
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.gray)
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    SearchView(searchText: .constant(""))
}
