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
    @State private var searchResults: [MKMapItem] = []
    @Environment(\.dismiss) private var dismiss
    
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
            
            VStack {
                // Search and Reset controls
                HStack {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                        .onTapGesture {
                            dismiss()
                        }
                    
                    MapSearchView(searchResults: $searchResults, onLocationSelect: { selectedLocation in
                        userLocation = selectedLocation
                        cameraPosition = .automatic
                    }, onReset: {
                        userLocation = nil
                    })
                }
                .padding()
                
                // Search results list
                if !searchResults.isEmpty {
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(searchResults, id: \.self) { item in
                                Text(item.name ?? "Unknown Location")
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        let coordinate = item.placemark.coordinate
                                        userLocation = coordinate
                                        cameraPosition = .automatic
                                        searchResults = []
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .background(Color.white)
                }
            }
        }
        .toolbar(.hidden)
        .toolbar(.hidden, for: .tabBar)
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

struct MapSearchView: View {
    @State var searchText = ""
    @Binding var searchResults: [MKMapItem]
    var onLocationSelect: (CLLocationCoordinate2D) -> Void
    var onReset: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search location ...", text: $searchText, onCommit: {
                    searchForLocation()
                })
                .padding(.leading, 5)
                
                // Reset button
                Button(action: {
                    searchText = ""
                    onReset()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            .frame(height: 50)
            .background(Color(.systemGray6))
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.gray)
            )
        }
        .padding(.horizontal)
    }
    
    private func searchForLocation() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            if let items = response?.mapItems {
                searchResults = items
            }
        }
    }
}

#Preview {
    MapView()
}
