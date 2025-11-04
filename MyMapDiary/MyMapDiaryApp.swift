//
//  MyMapDiaryApp.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/17/24.
//

import SwiftData
import SwiftUI

@main
struct MyMapDiaryApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    if url.host == "addEntry" {
                        // Navigate to Add Entry screen
                        NotificationCenter.default.post(name: .openAddEntry, object: nil)
                    }
                }
        }
    }
}

extension Notification.Name {
    static let openAddEntry = Notification.Name("openAddEntry")
}
