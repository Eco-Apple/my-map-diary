//
//  GlassBg.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 11/24/24.
//

import SwiftUI

struct GlassBgParams {
    var size: CGSize = CGSize(width: 33, height: 33)
    var radius: CGFloat = 40
    var opacity: Double = 0.90
}

struct GlassBg: View {
    var params: GlassBgParams
    
    var body: some View {
        Color
            .glassBg
            .frame(width: params.size.width, height: params.size.height)
            .blur(radius: params.radius)
            .opacity(params.opacity)
    }
}
