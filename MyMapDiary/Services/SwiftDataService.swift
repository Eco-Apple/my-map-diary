//
//  SwiftDataService.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import SwiftData
import UIKit

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Location.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
    func getLocations() -> [Location] {
        do {
            var locations = try modelContext.fetch(FetchDescriptor<Location>())
            #if DEBUG
            locations.append(contentsOf: demoLocations())
            #endif
            return locations
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addLocation(_ location: Location) {
        do {
            modelContext.insert(location)
            
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func delLocation(_ loc: Location) {
        do {
            modelContext.delete(loc)
            
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
#if DEBUG
    func demoLocations() -> [Location] {
        return [
            Location(latitude: 9.916667, longitude: 124.166664, imageData: UIImage(named: "bohol")!.jpegData(compressionQuality: 80)!),
            Location(latitude: 11.968603, longitude: 121.918381, imageData: UIImage(named: "boracay")!.jpegData(compressionQuality: 80)!),
            Location(latitude: 9.87083, longitude: 126.05111, imageData: UIImage(named: "siargao")!.jpegData(compressionQuality: 80)!),
            Location(latitude: 10.166666, longitude: 118.916663, imageData: UIImage(named: "puerto")!.jpegData(compressionQuality: 80)!),
            Location(latitude: 20.3166654, longitude: 121.8666632, imageData: UIImage(named: "batanes")!.jpegData(compressionQuality: 80)!),
            Location(latitude: 14.0999996, longitude: 120.9333296, imageData: UIImage(named: "tagaytay")!.jpegData(compressionQuality: 80)!),
            Location(latitude: 7.196276, longitude: 125.461807, imageData: UIImage(named: "davao")!.jpegData(compressionQuality: 80)!),
            Location(latitude: 16.41639, longitude: 120.59306, imageData: UIImage(named: "baguio")!.jpegData(compressionQuality: 80)!),
        ]
    }
#endif
    
#if DEBUG
    func debugDeleteAllLocations() {
        do {
            let allLoc = try modelContext.fetch(FetchDescriptor<Location>())
            
            for loc in allLoc {
                modelContext.delete(loc)
            }
            
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
#endif
}
