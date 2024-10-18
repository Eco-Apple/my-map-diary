//
//  ContentView.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/17/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var locManager = LocationManager()
    
    var body: some View {
        Navigation {
            MapScreen()
        }
        .environment(locManager)
    }
}

#Preview {
    ContentView()
}
