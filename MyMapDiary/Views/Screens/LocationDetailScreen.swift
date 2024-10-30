//
//  LocationDetailScreen.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/23/24.
//

import SwiftUI
import Combine

struct LocationDetailScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var location: Location
    @State private var isKeyboardVisible = false
    
    let defaultHeight = 300.0
    
    var body: some View {
        ZStack {
            VStack {
                Image(uiImage: location.uiImage)
                    .resizable()
                    .scaledToFill()
                Spacer()
                    .frame(height: defaultHeight + ( isKeyboardVisible ? 150 : 0))
            }
            .ignoresSafeArea(.all)
            
            VStack(spacing: .zero) {
                Spacer()
                VStack {
                    Spacer()
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
                    .scrollDisabled(true)
                    .offset(y: -40)
                }
                .frame(height: defaultHeight + ( isKeyboardVisible ? 150 : 0))
                .padding(.top, 55)
                .background(Color(.systemGroupedBackground))
            }
            .frame(width: UIScreen.main.bounds.width)
            
            VStack {
                Spacer()
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Label("Back", systemImage: "chevron.backward")
                    }
                    .padding()
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                    }
                    .padding()
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(.clear)
                
                Spacer()
                    .frame(height: defaultHeight + ( isKeyboardVisible ? 150 : 0))
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
        .onReceive(Publishers.keyboardVisible) { isVisible in
            isKeyboardVisible = isVisible
        }
    }
}


// Keyboard visibility publisher
extension Publishers {
    static var keyboardVisible: AnyPublisher<Bool, Never> {
        let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }
        let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }

        return MergeMany(keyboardWillShow, keyboardWillHide)
            .eraseToAnyPublisher()
    }
}

#Preview {
    LocationDetailScreen(location: .preview)
}
