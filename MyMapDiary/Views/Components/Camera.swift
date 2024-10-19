//
//  CameraV2.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/19/24.
//

import AVFoundation
import SwiftUI

// Camera Preview Layer
struct Camera: UIViewRepresentable {
    var camera: ViewModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.previewLayer = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.previewLayer.frame = view.frame
        camera.previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.previewLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
