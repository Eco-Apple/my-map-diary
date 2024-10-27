//
//  LocationDetailScreen.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/23/24.
//

import SwiftUI

struct LocationDetailScreen: View {
    @State var location: Location
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image(uiImage: location.uiImage)
                    .resizable()
                    .scaledToFill()
                
                Color.black.opacity(0.3)
            }
            .frame(height: UIScreen.main.bounds.height * 0.6)
            
            Form {
                Section {
                    TextField("Title", text: $location.title)
                }
                
                Section {
                    TextEditor(text: $location.message)
                        .placeHolder("Share your thoughts or memories...", text: $location.message)
                        .frame(height: 150)
                }
            }
            .listSectionSpacing(.compact)
        }
        .padding(.top, -100)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(.all)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            Button("Delete this location", systemImage: "trash") {
                
            }
        }
    }
}

#Preview {
    LocationDetailScreen(location: .preview)
}
