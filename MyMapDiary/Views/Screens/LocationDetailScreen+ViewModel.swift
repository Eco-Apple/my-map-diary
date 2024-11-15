//
//  LocationDetailScreen+ViewModel.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 11/15/24.
//

import Foundation

extension LocationDetailScreen {
    
    @Observable
    class ViewModel {
        var location: Location
        
        var isDeletePresented: Bool = false
        
        private let dataService: SwiftDataService
        
        init(dataService: SwiftDataService, location: Location) {
            self.location = location
            self.dataService = dataService
        }
        
        func delLoc() {
            dataService.delLocation(location)
        }
    }
}
