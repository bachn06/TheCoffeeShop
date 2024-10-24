//
//  UserEnvironment.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import Foundation
import CoreLocation

final class UserEnvironment: ObservableObject {
    @Published var userId: UUID = (UUID(uuidString: UserDefaultsStorage.shared.getUserId()) ?? UUID())
    @Published var userName: String = ""
    @Published var phoneNumber: String = ""
    @Published var imageUrl: String = ""
    @Published var address: String = ""
    @Published var products: [Product] = []
    @Published var categories: [ProductCategory] = []
    @Published var favouriteProducts: [Product] = []
    
    private var debounceWorkItem: DispatchWorkItem?
    
    func scheduleUpdateProducts(_ productId: UUID) {
        debounceWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            APIService.shared.updateFavouriteProduct(productId: productId) { _ in }
        }
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
    
    func updateProfile() {
        APIService.shared.updateProfile(user: User(id: userId, name: userName, avatar: imageUrl, phone: phoneNumber, address: address)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self.updateUserInfo(user)
                case .failure:
                    break
                }
            }
        }
    }
    
    func updateUserInfo(_ user: User) {
        userName = user.name
        phoneNumber = user.phone
        imageUrl = user.avatar
        address = user.address
    }
    
    func toggleFavourite(_ product: Product) {
        if let index = favouriteProducts.firstIndex(where: { $0.id == product.id }) {
            favouriteProducts.remove(at: index)
        } else {
            var product = product
            product.isFavourite = true
            favouriteProducts.append(product)
        }
        
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].isFavourite.toggle()
        }
        
        scheduleUpdateProducts(product.id)
    }
    
    func checkLocationServices() {
        let mapQueue = DispatchQueue(label: "com.bachng.dev.mapService")
        mapQueue.async {
            guard CLLocationManager.locationServicesEnabled() else { return }
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}
