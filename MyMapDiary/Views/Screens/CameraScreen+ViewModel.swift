//
//  CameraScreen+ViewModel.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import AVFoundation
import SwiftUI

extension CameraScreen {
    
    @Observable
    class ViewModel {
        var camera = Camera.ViewModel()
        var flash = false
        var isFrontCamera = false {
            didSet {
                camera.position(isFrontCamera ? .front : .back)
            }
        }
        
        func toggleFlash() {
            flash.toggle()
        }
        
        func takePicture() {
            camera.takePicture(isFlashOn: flash)
        }
        
        func toggleCamera() {
            isFrontCamera.toggle()
        }
    }
}
