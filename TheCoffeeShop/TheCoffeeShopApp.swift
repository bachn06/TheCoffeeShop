//
// TheCoffeeShopApp.swift
// TheCoffeeShop
//
// Created by BachNguyen on 27/9/24.
// 

import SwiftUI

@main
struct TheCoffeeShopApp: App {
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
                        case .mapView:
                            MapView()
                        case .productDetail(let item):
                            ItemDetailView(cartItem: item)
                        case .createOrderView(let cartItems):
                            CreateOrderView(cartItems: cartItems)
                        case .orderConfimationView:
                            OrderConfirmationView()
                        case .orderTrackingDetail:
                            OrderStatusDetailsView()
                        }
                    }
            }
            .environmentObject(router)
            .environmentObject(userEnvironment)
            .environmentObject(cartEnvironment)
        }
    }
}
