//
//  MapScreen+ViewModel.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import CoreLocation
import AVFoundation
import SwiftData
import SwiftUI
import MapKit


extension MapScreen {
    @Observable
    class ViewModel {
        var initPos: MapCameraPosition? = nil
        var isCameraPresented: Bool = false
        
        private(set) var locations: [Location] = []
        
        private let dataService: SwiftDataService
        
        init(dataService: SwiftDataService) {
            self.dataService = dataService
            
            locations = dataService.getLocations()
        }
        
        func fetchLocations() {
            locations = dataService.getLocations()
        }
        
        func pinLoc(at loc: CLLocation, imgData: Data) {
            
            let location = Location(
                latitude: loc.coordinate.latitude,
                longitude: loc.coordinate.longitude,
                imageData: imgData
            )
            
            dataService.addLocation(location)
            
            locations.append(location)
        }
        
        func setMap(loc: CLLocation) {
            initPos = .camera(
                MapCamera(
                    centerCoordinate: CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude),
                    distance: 500,
                    heading: 0,
                    pitch: 45
                )
            )
        }
        
        func showCamera() {
            isCameraPresented = true
        }
        
        #if DEBUG
        func debugDeleteAllLocation() {
            dataService.debugDeleteAllLocations()
            
            locations = []
        }
        #endif
    }
    
}
