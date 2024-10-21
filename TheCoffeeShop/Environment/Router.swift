//
//  Router.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var presentingSheet: Route?
    @Published var presentingFullScreen: Route?
    
    enum NavigationType {
        case push
        case presentSheet
        case presentFullScreen
    }
    
    enum Route: Hashable, Identifiable {
        case loginView
        case tabbarView
        
        var id: UUID {
            UUID()
        }
    }
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func dismiss() {
        if !path.isEmpty {
            path.removeLast()
        } else if presentingSheet != nil {
            presentingSheet = nil
        } else if presentingFullScreen != nil {
            presentingFullScreen = nil
        }
    }
    
    func popView() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
