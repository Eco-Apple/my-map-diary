//
//  MapScreen.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import SwiftData
import SwiftUI
import MapKit

struct MapScreen: View {
    @Environment(LocationManager.self) var locManager
    
    @State private var viewModel = ViewModel(dataService: .shared)
    
    var body: some View {
        MapReader { proxy in
            ZStack {
                if let initPos = viewModel.initPos {
                    Map(initialPosition: initPos) {
                        ForEach(viewModel.locations){ location in
                            Annotation("Test", coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                            }
                        }
                    }
                    .toolbar(.hidden)
                    .mapStyle(.hybrid)
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: action) {
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(color: .gray, radius: 4, x: 0, y: 2)
                        }
                        .frame(width: 70, height: 70)
                        .padding()
                    }
                }
            }
            .onChange(of: locManager.currLoc){ old, new in
                guard let current = new else { return }
                
                viewModel.setMap(loc: current)
            }
            .fullScreenCover(isPresented: $viewModel.isCameraPresented) {
                CameraScreen(pinLoc: viewModel.pinLoc)
            }
        }
    }
    
    func action() {
        viewModel.isCameraPresented = true
    }
}

#Preview {
    MapScreen()
}
