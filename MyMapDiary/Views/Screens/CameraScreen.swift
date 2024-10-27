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
    
    var pinLoc: ((CLLocation, Data) -> Void)? = nil
    
    var body: some View {
        ZStack {
            Color
                .black
                .edgesIgnoringSafeArea(.all)
            
            if let uiImage = viewModel.camera.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                Spacer()
                VStack {
                    Spacer()
                    HStack {
                        if !viewModel.camera.session.isRunning {
                            Button("Cancel") {
                                viewModel.camera.photoData = nil
                            }
                            Spacer()
                            Button("Save", action: action)
                        }
                    }
                }
            } else {
                
                #if !targetEnvironment(simulator)
                Camera(camera: viewModel.camera)
                    .edgesIgnoringSafeArea(.all)
                #endif
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button("Cancel") {
                            viewModel.camera.session.stopRunning()
                            dismiss()
                        }
                        Spacer()
                        Button(action: viewModel.camera.takePicture) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 70, height: 70)
                                .shadow(radius: 5)
                        }
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
    }
    
    func action() {
        guard let current = locManager.currLoc else { return }
        guard let pinLoc = pinLoc else { return }
        guard let data = viewModel.camera.photoData else { return }
        
        pinLoc(current, data)
        
        dismiss()
    }
}

#Preview {
    CameraScreen()
}
