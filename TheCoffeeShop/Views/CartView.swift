//
//  CartView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct CartView: View {
    @SceneStorage("selectionTab") var pageIndex = 3
    @EnvironmentObject var tabbarRouter: TabBarRouter
    
    var body: some View {
        ZStack {
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    CartView()
}
