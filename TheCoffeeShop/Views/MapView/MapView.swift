//
//  MapView.swift
//  TheCoffeeShop
//
//  Created by BachNguyen on 28/9/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var userEnvironment: UserEnvironment
    @EnvironmentObject var router: Router
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var userLocation: CLLocationCoordinate2D?
    @State private var searchResults: [MKMapItem] = []
    @State private var address: String?
    @State private var searchContentSize: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition) {
                if let userLocation {
                    Marker(address ?? "", coordinate: userLocation)
                }
            }
            
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                        .onTapGesture {
                            router.popView()
                        }
                    
                    VStack {
                        MapSearchView(searchResults: $searchResults, onLocationSelect: { selectedLocation in
                            userLocation = selectedLocation
                            cameraPosition = .automatic
                            updateAddress()
                        }, onReset: {
                            userLocation = nil
                        })
                        .overlay {
                            GeometryReader { geo in
                                Color.clear.onAppear {
                                    searchContentSize = geo.size
                                }
                            }
                        }
                        if !searchResults.isEmpty {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    ForEach(searchResults, id: \.self) { item in
                                        Text(item.getDetailAddress())
                                            .padding()
                                            .cornerRadius(8)
                                            .onTapGesture {
                                                let coordinate = item.placemark.coordinate
                                                userLocation = coordinate
                                                cameraPosition = .automatic
                                                searchResults = []
                                                updateAddress()
                                            }
                                            .frame(width: searchContentSize.width, alignment: .leading)
                                    }
                                }
                                .background(Color(.systemGray6))
                            }
                            .frame(width: searchContentSize.width)
                            .frame(maxHeight: 110)
                            .background(.gray)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            checkLocationServices()
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
    }
    
    private func updateAddress() {
        userLocation?.getAddress(completion: { address in
            self.address = address
            userEnvironment.address = address ?? ""
        })
    }
    
    private func checkLocationServices() {
        let mapQueue = DispatchQueue(label: "com.bachng.dev.mapService")
        mapQueue.async {
            guard CLLocationManager.locationServicesEnabled() else { return }
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()

            if let location = locationManager.location?.coordinate {
                userLocation = location
                updateAddress()
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
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search ...", text: $searchText, onEditingChanged: { isEditing in
                    searchForLocation()
                })
                .padding(.leading, 5)

                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        searchResults.removeAll()
                        onReset()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
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
        .onAppear {
            searchResults.removeAll()
        }
    }
    
    private func searchForLocation() {
        guard !searchText.isEmpty else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let items = response?.mapItems {
                print(items)
                searchResults = items
            }
        }
    }
}

#Preview {
    MapView()
        .environmentObject(UserEnvironment())
        .environmentObject(Router())
}
