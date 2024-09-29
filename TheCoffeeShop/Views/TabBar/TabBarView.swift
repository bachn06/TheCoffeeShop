//
//  BottomTabBarView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

class TabBarRouter: ObservableObject {
    @Published var currentPage: Page = .home
}

enum Page {
    case home
    case favourite
    case cart
    case profile
}

struct TabBarView: View {
    @StateObject var tabbarRouter = TabBarRouter()
    
    @ViewBuilder var contentView: some View {
        switch tabbarRouter.currentPage {
        case .home:
            HomeView()
                .environmentObject(tabbarRouter)
        case .favourite:
            FavouriteView()
                .environmentObject(tabbarRouter)
        case .cart:
            CartView()
                .environmentObject(tabbarRouter)
        case .profile:
            ProfileView()
                .environmentObject(tabbarRouter)
        }
    }

    var body: some View {
        let items = [
            TabBarItem(icon: "house.fill", title: "Home", action: {}, tabbarRouter: tabbarRouter, assignedPage: .home),
            TabBarItem(icon: "heart.fill", title: "Favourite", action: {}, tabbarRouter: tabbarRouter, assignedPage: .favourite),
            TabBarItem(icon: "cart.fill", title: "Cart", badge: 3, action: {}, tabbarRouter: tabbarRouter, assignedPage: .cart),
            TabBarItem(icon: "person.fill", title: "Profile", showProfileImage: false, action: {}, tabbarRouter: tabbarRouter, assignedPage: .profile)
        ]
        ZStack {
            VStack {
                contentView
                Spacer()
                    .frame(height: 80)
            }
            .ignoresSafeArea(edges: .bottom)
            
            VStack {
                Spacer()
                HStack(alignment: .top) {
                    ForEach(items, id: \.title) { item in
                        TabBarItem(icon: item.icon, title: item.title, badge: item.badge, action: {}, tabbarRouter: tabbarRouter, assignedPage: item.assignedPage)
                    }
                    .frame(maxWidth: .infinity)
                }
                .background(Color(hex: "#F8F7FA"))
            }
        }
    }
}

#Preview {
    TabBarView()
}
