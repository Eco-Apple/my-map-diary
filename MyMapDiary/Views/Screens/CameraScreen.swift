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
                NavigationStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button(action: {
                                    viewModel.camera.photoData = nil
                                }) {
                                    Label("Cancel", systemImage: "chevron.backward")
                                }
                            }
                            
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Save", action: action)
                            }
                        }
                }
            } else {
                
                #if !targetEnvironment(simulator)
                Camera(camera: viewModel.camera)
                    .edgesIgnoringSafeArea(.all)
                #endif
                
                #if targetEnvironment(simulator)
                GeometryReader { proxy in
                    Image(.camera)
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width)
                        .ignoresSafeArea()
                }
                #endif
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear, Color.black.opacity(0.9)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                .allowsHitTesting(false)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            dismiss()
                        } label: {
                            ZStack {
                                Color
                                    .glassBg
                                    .frame(width: 33, height: 33)
                                    .blur(radius: 40)
                                    .opacity(0.90)
                                    .clipShape(Circle())
                                
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15))
                            }
                        }
                    }
                    .padding(.trailing, 20)
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        Color
                            .glassBg
                            .frame(width: 350, height: 90)
                            .blur(radius: 35)
                            .opacity(0.25)
                            .cornerRadius(50)
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
                            .padding(.bottom)
                        
                        
                        HStack {
                            Spacer()
                            
                            Button(action: viewModel.toggleFlash) {
                                ZStack {
                                    Color
                                        .glassBg
                                        .frame(width: 63, height: 63)
                                        .blur(radius: 40)
                                        .opacity(0.90)
                                        .clipShape(Circle())
                                    
                                    Image(systemName: viewModel.flash ? "bolt.fill" : "bolt.slash.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 25))
                                }
                            }
                            
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                            Spacer()
                            
                            Button(action: viewModel.takePicture) {
                                ZStack {
                                    Circle()
                                        .stroke(Color.white, lineWidth: 5)
                                        .frame(width: 60, height: 60)
                
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 59, height: 50)
                                }
                            }
                            
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                            
                            Button(action: viewModel.toggleCamera) {
                                ZStack {
                                    Color
                                        .glassBg
                                        .frame(width: 63, height: 63)
                                        .blur(radius: 40)
                                        .opacity(0.90)
                                        .clipShape(Circle())
                                    
                                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.camera.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 25))
                                }
                            }
    
                            Spacer()
                        }
                        .frame(width: 300, height: 100)
                        .padding(.bottom)
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
    var locManager = LocationManager()
    
    return CameraScreen()
        .environment(locManager)
}
