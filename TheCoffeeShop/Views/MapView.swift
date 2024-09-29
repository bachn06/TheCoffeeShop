//
//  MapView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var userLocation: CLLocationCoordinate2D?
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition) {
                if let userLocation {
                    Marker("", coordinate: userLocation)
                }
            }
            .onAppear {
                checkLocationServices()
            }
            
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                    .onTapGesture {
                        
                    }
                
                SearchView()
            }
            .padding()
        }
    }
    
    private func checkLocationServices() {
        let mapQueue = DispatchQueue(label: "com.bachng.dev.mapService")
        mapQueue.async {
            guard CLLocationManager.locationServicesEnabled() else { return }
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()

            if let location = locationManager.location?.coordinate {
                userLocation = location
            }
        }
    }
}

#Preview {
    MapView()
}
