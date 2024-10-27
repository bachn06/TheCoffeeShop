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
    
    var title: String {
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
    
    var icon: Image {
        switch self {
        case .home:
            AppImage.home
        case .favorite:
            AppImage.favourite
        case .cart:
            AppImage.cart
        case .profile:
            AppImage.profile
        }
    }
}

struct TabBarView: View {
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
                    VStack {
                        Rectangle()
                            .frame(width: titleWidth(title: item.title), height: 3)
                            .foregroundStyle(selectedTab == item ? .red : .clear)
                        ZStack {
                            if let profileURL = URL(string: viewModel.getProfileImageURL(userEnvironment)),
                               item == .profile {
                                AsyncCachedImage(url: profileURL) { image in
                                    image
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .clipShape(Circle())
                                } placeholder: {
                                    item.icon
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(
                                            gradient(for: item)
                                        )
                                }

                            } else {
                                item.icon
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(
                                        gradient(for: item)
                                    )
                            }
                            
                            if let badge = viewModel.getBadge(cartEnvironment),
                               item == .cart {
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
                        Text(item.title)
                            .font(.caption)
                            .foregroundStyle(
                                gradient(for: item)
                            )
                    }
                    .onTapGesture {
                        selectedTab = item
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .background(Color(hex: "#F8F7FA"))
        }
        .onAppear(perform: {
            viewModel.fetchProfile(userEnvironment)
            viewModel.fetchCart(cartEnvironment)
        })
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
    }
    
    private func gradient(for item: TabbarItems) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: selectedTab == item ? [Color(hex: "#CB8A58"), Color(hex: "#562B1A")] : [Color(hex: "#CBCBD4")]),
            startPoint: .leading, endPoint: .trailing
        )
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
        .environmentObject(CartEnvironment())
}
