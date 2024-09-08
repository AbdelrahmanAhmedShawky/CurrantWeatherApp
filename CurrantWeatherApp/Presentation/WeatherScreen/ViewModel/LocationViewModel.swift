//
//  LocationViewModel.swift
//  CurrantWeatherApp
//
//  Created by Macbook  on 08/09/2024.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        private let locationManager: CLLocationManager
        private var listeners: [() -> Void] = []
        @Published var currentPlacemark: CLPlacemark?
        @Published var lastSeenLocation: CLLocation?
        @Published var authorizationStatus: CLAuthorizationStatus
        override init() {
            locationManager = CLLocationManager()
            authorizationStatus = locationManager.authorizationStatus
            
            super.init()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        func addListener(callback: @escaping () -> Void) {
            self.listeners.append(callback)
        }

        func requestLocation() {
            locationManager.requestWhenInUseAuthorization()
        }
    
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            authorizationStatus = manager.authorizationStatus
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            self.lastSeenLocation = locations.first
            CLGeocoder().reverseGeocodeLocation(locations.first!) { (placemark, error) in
                self.currentPlacemark = placemark?.last
            }
            
            for callback in listeners {
                callback()
            }
        }
    
    var requestLocationButton: some View {
            Button {
                self.requestLocation()
            } label: {
                Text("Share My Current Location")
                    .frame(width: 280, height: 50)
                    .background(.white)
                    .foregroundColor(.blue)
                    .font(.system(size: 20, weight: .bold))
                    .cornerRadius(10)
                
            }
    }
    
    var cityTextView: some View {
        Text(getLocationCityAndState())
            .font(.system(size: 32, weight: .medium))
            .foregroundColor(.white)
            .padding()
    }
    
    func getLocationCityAndState() -> String {
        guard let placemark = self.currentPlacemark else {
            return ""
        }
        let state = placemark.administrativeArea ?? ""
        let city = placemark.country ?? ""
        
        return city
    }
}
