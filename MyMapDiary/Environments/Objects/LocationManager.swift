//
//  Location.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import Foundation
import CoreLocation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private var locManager = CLLocationManager()
    
    private(set) var currLoc: CLLocation? = nil

    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        currLoc = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
