//
//  TransparentButton.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 11/24/24.
//

import SwiftUI

struct TransparentIconButton<Content: View>: View {
    var glassBgParams: GlassBgParams = GlassBgParams(
        size: CGSize(width: 33, height: 33)
    )
    
    let action: () -> Void
    let label: () -> Content
    
    
    var body: some View {
        Button(action: action) {
            ZStack {
                GlassBg(params: glassBgParams)
                    .clipShape(Circle())
                
                label()
            }
        }
    }
}


struct TransparentTextButton<Content: View>: View {
    var glassBgParams: GlassBgParams
    var radius: CGFloat
    
    let action: () -> Void
    let label: () -> Content
    
    
    var body: some View {
        Button(action: action) {
            ZStack {
                GlassBg(params: glassBgParams)
                    .cornerRadius(radius)
                
                label()
            }
        }
    }
}

#Preview {
    return VStack {
        TransparentIconButton {
            
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .font(.system(size: 15))
        }
        
        TransparentTextButton(
            glassBgParams: GlassBgParams(
                size: CGSize(width: 90, height: 33),
                radius: 40,
                opacity: 0.70
            ),
            radius: 16
        ){
            
        } label: {
            Text("Save")
                .foregroundStyle(.white)
        }
    }
}
