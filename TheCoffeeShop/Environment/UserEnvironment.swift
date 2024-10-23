//
//  UserEnvironment.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import Foundation
import CoreLocation

final class UserEnvironment: ObservableObject {
    @Published var userName: String = ""
    @Published var phoneNumber: String = ""
    @Published var imageUrl: String = "https://avatars.githubusercontent.com/u/64175324"
    @Published var address: String = ""
    @Published var products: [Product] = []
    @Published var categories: [ProductCategory] = []
    @Published var favouriteProducts: [Product] = []
    
    func toggleFavourite(_ product: Product) {
        if let index = favouriteProducts.firstIndex(where: { $0 == product }) {
            favouriteProducts.remove(at: index)
        } else {
            favouriteProducts.append(product)
        }
        
        if let index = products.firstIndex(where: { $0 == product }) {
            products[index].isFavourite.toggle()
        }
    }
    
    func checkLocationServices() {
        let mapQueue = DispatchQueue(label: "com.bachng.dev.mapService")
        mapQueue.async {
            guard CLLocationManager.locationServicesEnabled() else { return }
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()

            if let location = locationManager.location?.coordinate {
                location.getAddress { address in
                    self.address = address ?? ""
                }
            }
        }
    }
}

extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}
