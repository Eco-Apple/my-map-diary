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
                
                #if !targetEnvironment(simulator)
                GeometryReader { proxy in
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width)
                        .ignoresSafeArea()
                }
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
                    gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear, Color.black.opacity(0)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                .allowsHitTesting(false)
                
                VStack {
                    HStack(alignment: .center){
                        
                        TransparentIconButton(
                            glassBgParams: GlassBgParams(radius: 25, opacity: 0.9)
                        ){
                            viewModel.camera.photoData = nil
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                        }
                        
                        Spacer()
//
                        TransparentTextButton(
                            glassBgParams: GlassBgParams(
                                size: CGSize(width: 90, height: 33),
                                radius: 40,
                                opacity: 0.70
                            ),
                            radius: 16
                        ){
                            save()
                        } label: {
                            Text("Save")
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal, 20)
                    
                    Spacer()
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
                        TransparentIconButton(
                            glassBgParams: GlassBgParams(radius: 25, opacity: 0.9)
                        ){
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
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
                            
                            TransparentIconButton(
                                glassBgParams: GlassBgParams(
                                    size: CGSize(width: 62, height: 63)
                                ),
                                action: viewModel.toggleFlash
                            ){
                                Image(systemName: viewModel.flash ? "bolt.fill" : "bolt.slash.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
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
                            
                            TransparentIconButton(
                                glassBgParams: GlassBgParams(
                                    size: CGSize(width: 62, height: 63)
                                ),
                                action: viewModel.toggleCamera
                            ){
                                Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.camera.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))
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
    
    func save(){
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
