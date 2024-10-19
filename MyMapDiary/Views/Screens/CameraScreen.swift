//
//  CameraScreen.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//


import AVFoundation
import CoreLocation
import SwiftData
import SwiftUI

struct CameraScreen: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(LocationManager.self) var locManager
    
    @State private var viewModel = ViewModel()
    
    var pinLoc: ((CLLocation) -> Void)? = nil
    
    var body: some View {
        ZStack {
            if let uiImage = viewModel.camera.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                Spacer()
                VStack {
                    Spacer()
                    HStack {
                        Button("Cancel") {
                            viewModel.camera.photoData = nil
                        }
                        Spacer()
                        Button("Save", action: action)
                    }
                }
            } else {
                Camera(camera: viewModel.camera)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: viewModel.camera.takePicture) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 70, height: 70)
                                .shadow(radius: 5)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.camera.checkAuthorization()
        }
    }
    
    func action() {
        guard let current = locManager.currLoc else { return }
        guard let pinLoc = pinLoc else { return }
        
        pinLoc(current)
        
        dismiss()
    }
}

#Preview {
    CameraScreen()
}
