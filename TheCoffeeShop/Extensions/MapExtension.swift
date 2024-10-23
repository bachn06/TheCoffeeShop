//
//  MapExtension.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 23/10/24.
//

import CoreLocation
import MapKit

extension CLLocationCoordinate2D {
    func getAddress(completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemarks found.")
                completion(nil)
                return
            }
            
            let address = placemark.getDetailAddress()
            completion(address)
        }
    }
}

extension CLPlacemark {
    func getDetailAddress() -> String {
        let addressComponents = [
            self.name,
            self.locality,
            self.country
        ]
        return addressComponents.compactMap({ $0 }).joined(separator: ", ")
    }
}

extension MKMapItem {
    func getDetailAddress() -> String {
        let placemark = self.placemark
        
        let addressComponents = [
            placemark.name,
            placemark.locality,
            placemark.country
        ]
        
        return addressComponents.compactMap({ $0 }).joined(separator: ", ")
    }
}
