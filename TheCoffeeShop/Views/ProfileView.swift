//
//  ProfileView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

struct ProfileView: View {
    @SceneStorage("selectionTab") var pageIndex = 4
    @EnvironmentObject var tabbarRouter: TabBarRouter
    
    var body: some View {
        ZStack {
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ProfileView()
}
