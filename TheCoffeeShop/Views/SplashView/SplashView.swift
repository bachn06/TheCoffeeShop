//
//  SplashView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var userEnvironment: UserEnvironment
    @StateObject var viewModel: SplashViewModel = SplashViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color(hex: "#422110")
            Image("splashImage", bundle: nil)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.fetchProducts(userEnvironment) {
                router.push(.loginView)
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(UserEnvironment())
        .environmentObject(Router())
}
