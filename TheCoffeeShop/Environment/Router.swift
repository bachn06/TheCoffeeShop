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
    @Published private var routeStack: [Route] = []
    
    enum NavigationType {
        case push
        case presentSheet
        case presentFullScreen
    }
    
    enum Route: Hashable, Identifiable {
        case loginView
        case tabbarView
        case productDetail(CartItem)
        case mapView
        case createOrderView([CartItem])
        case orderConfimationView
        case orderTrackingDetail
        
        var id: UUID {
            UUID()
        }
    }
    
    func push(_ route: Route) {
        routeStack.append(route)
        path.append(route)
    }
    
    func dismiss() {
        if !path.isEmpty {
            path.removeLast()
            routeStack.removeLast()
        } else if presentingSheet != nil {
            presentingSheet = nil
        } else if presentingFullScreen != nil {
            presentingFullScreen = nil
        }
    }
    
    func popView() {
        if !path.isEmpty {
            path.removeLast()
            routeStack.removeLast()
        }
    }
    
    func popToView(_ route: Route) {
        if let index = routeStack.firstIndex(of: route) {
            let newStack = Array(routeStack.prefix(index + 1))
            routeStack = newStack
            path = NavigationPath()
            newStack.forEach { path.append($0) }
        }
    }
    
    func popToRoot() {
        routeStack.removeAll()
        path.removeLast(path.count)
    }
    
    func setRoot(_ route: Route) {
        path = NavigationPath()
        routeStack.removeAll()
        push(route)
    }
}
