//
//  ImageFullScreen.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 11/24/24.
//

import SwiftUI

struct ImageFullScreen: View {
    @Environment(\.dismiss) var dismiss
    
    let location: Location
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image(uiImage: location.uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width)
                    .ignoresSafeArea()
            }
            
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
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ImageFullScreen(location: .preview)
}
