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
        private(set) var initPos: MapCameraPosition? = nil
        var isCameraPresented: Bool = false
        
        private(set) var locations: [Location] = []
        
        private let dataService: SwiftDataService
        
        init(dataService: SwiftDataService) {
            self.dataService = dataService
            
            locations = dataService.getLocations()
        }
        
        func setMap(loc: CLLocation) {
            initPos = MapCameraPosition.region(
              MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude),
                  span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
              )
           )
        }
        
        func pinLoc(at loc: CLLocation, data: Data) {
            
            let location = Location(
                latitude: loc.coordinate.latitude,
                longitude: loc.coordinate.longitude
            )
            
            dataService.addLocation(location)
            
            locations.append(location)
        }
    }
    
}
