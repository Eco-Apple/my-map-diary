//
//  CameraScreen+ViewModel.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import AVFoundation
import SwiftUI

extension Camera {
    
    @Observable
    class ViewModel: NSObject, AVCapturePhotoCaptureDelegate {
        private var cameraPosition: AVCaptureDevice.Position = .back
        private var output = AVCapturePhotoOutput()
        
        var photoData: Data? = nil
        private(set) var session = AVCaptureSession()
        var previewLayer: AVCaptureVideoPreviewLayer!
        
        var uiImage: UIImage? {
            if let photoData {
                return UIImage(data: photoData)
            }
            
            return nil
        }
        
        func checkAuthorization() {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                setupSession()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        self.setupSession()
                    }
                }
            default:
                print("No access to camera.")
            }
        }
        
        func setupSession() {
            DispatchQueue.global(qos: .background).async {
                self.session.beginConfiguration()
                
                guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: self.cameraPosition) else { return }
                
                do {
                    let input = try AVCaptureDeviceInput(device: camera)
                    if self.session.canAddInput(input) {
                        self.session.addInput(input)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                if self.session.canAddOutput(self.output) {
                    self.session.addOutput(self.output)
                }
                
                self.session.commitConfiguration()
                self.session.startRunning()
            }
        }
        
        func takePicture() {
            let settings = AVCapturePhotoSettings()
            output.capturePhoto(with: settings, delegate: self)
        }
        
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let imageData = photo.fileDataRepresentation() else { return }
            photoData = imageData
            
            session.stopRunning()
        }
    }
}
