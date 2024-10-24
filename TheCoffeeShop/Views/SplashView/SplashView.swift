//
//  SplashView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color(hex: "#422110")
            Image("splashImage", bundle: nil)
        }
        .ignoresSafeArea()
        .onAppear {
            if UserStorage.shared.getAccessToken() != nil {
                router.push(.tabbarView)
            } else {
                router.push(.loginView)
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(Router())
}
