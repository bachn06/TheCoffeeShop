//
// TheCoffeeShopApp.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import SwiftUI

@main
struct TheCoffeeShopApp: App {
    @StateObject var locationEnvironment = LocationEnvironment()
    @StateObject var userEnvironment = UserEnvironment()
    @StateObject var cartEnvironment = CartEnvironment()
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SplashView()
                    .navigationDestination(for: Router.Route.self) { destination in
                        switch destination {
                        case .loginView:
                            LoginView()
                        case .tabbarView:
                            TabBarView()
                        case .orderTrackingDetail:
                            OrderStatusDetailsView()
                        }
                    }
            }
            .environmentObject(router)
            .environmentObject(userEnvironment)
            .environmentObject(cartEnvironment)
            .environmentObject(locationEnvironment)
        }
    }
}
