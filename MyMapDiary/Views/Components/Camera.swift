//
//  Camera.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import SwiftUI
import AVFoundation

struct Camera: UIViewControllerRepresentable {
    
//    @Binding var image: UIImage?
    
//    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
//        var parent: Camera
//
//        init(parent: Camera) {
//            self.parent = parent
//        }
//
//        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//            if let data = photo.fileDataRepresentation() {
//                let image = UIImage(data: data)
//                parent.image = image
//            }
//        }
//    }
    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        let captureSession = AVCaptureSession()
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera!")
            return viewController
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)

            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = viewController.view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            
            viewController.view.layer.addSublayer(previewLayer)
            
            let photoOutput = AVCapturePhotoOutput()
            captureSession.addOutput(photoOutput)
            
            captureSession.startRunning()
        } catch {
            print("Error setting up camera input: \(error)")
        }
        
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed
    }
}
