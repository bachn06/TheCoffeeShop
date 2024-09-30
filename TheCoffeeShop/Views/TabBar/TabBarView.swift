//
//  BottomTabBarView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI

enum TabbarItems: Int, CaseIterable {
    case home = 0
    case favorite
    case cart
    case profile
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorite"
        case .cart:
            return "Cart"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house.fill"
        case .favorite:
            return "heart.fill"
        case .cart:
            return "cart.fill"
        case .profile:
            return "person.fill"
        }
    }
}

struct TabBarView: View {
    @State var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)

                FavouriteView()
                    .tag(1)

                CartView()
                    .tag(2)

                ProfileView()
                    .tag(3)
            }

            ZStack{
                HStack {
                    ForEach((TabbarItems.allCases), id: \.self){ item in
                        TabBarItem(icon: item.iconName, title: item.title, badge: item.rawValue == 2 ? 3 : nil, isActive: (selectedTab == item.rawValue))
                            .onTapGesture {
                                selectedTab = item.rawValue
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#F8F7FA"))
            }
        }
    }
}

#Preview {
    TabBarView()
}
