//
//  BottomTabBarItem.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import UIKit
import SwiftUI

struct TabBarItem: View {
    let icon: String
    let title: String
    var badge: Int? = nil
    var showProfileImage: Bool = false
    let isActive: Bool

    var body: some View {
        VStack {
            Rectangle()
                .frame(width: titleWidth(title: title) ,height: 3)
                .foregroundStyle(isActive ? .red : .clear)
                .padding(.bottom, 5)
            if showProfileImage {
                Image("leaf.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
            } else {
                ZStack {
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(isActive ? .brown : .gray)
                    
                    if let badge = badge {
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
            }
            Text(title)
                .font(.caption)
                .foregroundColor(isActive ? .brown : .gray)
        }
        .padding(.top, 0)
    }
    
    private func titleWidth(title: String) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        let size = (title as NSString).size(withAttributes: attributes)
        return size.width
    }
}

#Preview {
    TabBarItem(icon: "house.fill", title: "Home", isActive: true)
}
