//
//  LocationEnvironment.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 20/10/24.
//

import MapKit

final class LocationEnvironment: ObservableObject {
    private var locationManager = CLLocationManager()
    @Published var address: String = "Select an address"
    
    
}
