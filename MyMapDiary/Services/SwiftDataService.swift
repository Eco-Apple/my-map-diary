//
//  SwiftDataService.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import SwiftData

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Location.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    func getLocations() -> [Location] {
        do {
            let locations = try modelContext.fetch(FetchDescriptor<Location>())
            
            return locations
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addLocation(_ location: Location) {
        modelContext.insert(location)
        do {
           try modelContext.save()
        } catch {
           fatalError(error.localizedDescription)
        }
    }
    
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
