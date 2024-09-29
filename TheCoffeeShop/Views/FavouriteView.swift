//
//  FavouriteView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct FavouriteView: View {
    @SceneStorage("selectionTab") var pageIndex = 1
    @EnvironmentObject var tabbarRouter: TabBarRouter
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                SearchView()
                    .padding(.horizontal, 10)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                        ForEach(menuItems, id: \.id) { item in
                            ListItemView(showQuantityOption: false)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    FavouriteView()
}
