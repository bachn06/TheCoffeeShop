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
    @EnvironmentObject var locationEnvironment: LocationEnvironment
    @EnvironmentObject var userEnvironment: UserEnvironment
    @EnvironmentObject var cartEnvironment: CartEnvironment
    @StateObject var viewModel: TabBarViewModel = TabBarViewModel()
    @State var selectedTab: TabbarItems = .home

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(TabbarItems.home)
                    .toolbar(.hidden, for: .tabBar)

                FavouriteView()
                    .tag(TabbarItems.favorite)
                    .toolbar(.hidden, for: .tabBar)

                CartView()
                    .tag(TabbarItems.cart)
                    .toolbar(.hidden, for: .tabBar)

                ProfileView()
                    .tag(TabbarItems.profile)
                    .toolbar(.hidden, for: .tabBar)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            HStack {
                ForEach((TabbarItems.allCases), id: \.self) { item in
                    let icon = item.iconName
                    let title = item.title
                    let isActive = selectedTab == item
                    
                    VStack {
                        Rectangle()
                            .frame(width: titleWidth(title: title), height: 3)
                            .foregroundStyle(isActive ? .red : .clear)
                        ZStack {
                            Image(systemName: icon)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(isActive ? .brown : .gray)
                            
                            if let badge = viewModel.getCart() {
                                Text("\(badge)")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .frame(width: 20, height: 20)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 10, y: -10)
                            }
                        }
                        Text(title)
                            .font(.caption)
                            .foregroundColor(isActive ? .brown : .gray)
                    }
                    .onTapGesture {
                        selectedTab = item
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .background(Color(hex: "#F8F7FA"))
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
    }
    
    private func titleWidth(title: String) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        let size = (title as NSString).size(withAttributes: attributes)
        return size.width
    }
}

#Preview {
    TabBarView()
        .environmentObject(UserEnvironment())
        .environmentObject(LocationEnvironment())
        .environmentObject(CartEnvironment())
}
