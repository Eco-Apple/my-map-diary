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
                #if targetEnvironment(simulator)
                Map()
                    .mapStyle(.hybrid)
                #else
                if let initPos = viewModel.initPos {
                    Map(initialPosition: initPos) {
                        ForEach(viewModel.locations){ location in
                            Annotation("", coordinate: location.coordinate) {
                                LocationPin(location: location)   
                            }
                        }
                        
                        UserAnnotation()
                    }
                    .toolbar(.hidden)
                    .mapStyle(.hybrid)
                }
                #endif
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0), Color.clear, Color.black.opacity(0.9)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                .allowsHitTesting(false)
                
                #if DEBUG
                VStack {
                    HStack {
                        Button(action: viewModel.debugDeleteAllLocation){
                            ZStack {
                                Color
                                    .glassBg
                                    .frame(width: 63, height: 63)
                                    .blur(radius: 35)
                                    .opacity(0.30)
                                    .clipShape(Circle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 55)
                                            .stroke(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 1
                                            )
                                            .opacity(0.5)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 55)
                                            .stroke(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.white.opacity(0), Color.white]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 1
                                            )
                                            .opacity(0.20)
                                    )
                                
                                
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
                            }
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
                            ZStack {
                                Color
                                    .glassBg
                                    .frame(width: 63, height: 63)
                                    .blur(radius: 35)
                                    .opacity(0.30)
                                    .clipShape(Circle())
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 55)
                                            .stroke(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 1
                                            )
                                            .opacity(0.5)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 55)
                                            .stroke(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.white.opacity(0), Color.white]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 1
                                            )
                                            .opacity(0.20)
                                    )
                                
                                
                                Image(systemName: "camera")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
                            }
                        }
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
            .onReceive(NotificationCenter.default.publisher(for: .openAddEntry)) { _ in
                viewModel.showCamera()  
            }
        }
        .onAppear {
            viewModel.fetchLocations()
        }
    }
}

#Preview {
    let locManager = LocationManager()
    
    MapScreen()
        .environment(locManager)
}
