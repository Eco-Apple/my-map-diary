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
                            Annotation("", coordinate: location.coordinate) {
                                LocationPin(location: location)   
                            }
                        }
                    }
                    .toolbar(.hidden)
                    .mapStyle(.hybrid)
                }
                
                #if DEBUG
                VStack {
                    HStack {
                        Button(action: viewModel.debugDeleteAllLocation){
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                                .shadow(color: .black, radius: 4, x: 0, y: 2)
                        }
                        
                        Spacer()
                    }
                    .padding(20)
                    
                    Spacer()
                }
                #endif
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: viewModel.showCamera) {
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                                .shadow(color: .black, radius: 4, x: 0, y: 2)
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
}

#Preview {
    MapScreen()
}
