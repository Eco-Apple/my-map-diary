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
    }
}
