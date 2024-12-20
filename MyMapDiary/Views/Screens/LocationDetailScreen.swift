//
//  LocationDetailScreen.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/23/24.
//

import SwiftUI
import Combine

struct LocationDetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.navigate) private var navigate
    
    @State private var viewModel: ViewModel
    
    let bottomDefaultHeight: CGFloat = 280.0
    
    init(location: Location) {
        _viewModel = State(initialValue: ViewModel(dataService: .shared, location: location))
    }
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { proxy in
                    Image(uiImage: viewModel.location.uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width)
                }
                
                Spacer()
                    .frame(height: bottomDefaultHeight)
                
            }
            .ignoresSafeArea(.all)
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.9), Color.clear, Color.black.opacity(0.9)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            .allowsHitTesting(false)
            
            VStack {
                HStack(alignment: .center){
                    Spacer()
                    
                    TransparentIconButton(
                        glassBgParams: GlassBgParams(radius: 25, opacity: 0.9)
                    ){
                        navigate(.location(.imgFullScreen(viewModel.location)))
                    } label: {
                        Image(systemName: "arrow.down.left.and.arrow.up.right")
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Form {
                    TextField("Title", text: $viewModel.location.title)
                    
                    TextEditor(text: $viewModel.location.message)
                        .placeHolder("Share your thoughts or memories...", text: $viewModel.location.message)
                        .frame(height: 150)
                }
                .frame(height: bottomDefaultHeight)
            }
            .scrollBounceBehavior(.basedOnSize)
            
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Label("Back", systemImage: "chevron.backward")
                        }
                        
                        Spacer()
                        
                        Button("", systemImage: "trash") {
                            viewModel.isDeletePresented = true
                        }
                        .alert(isPresented: $viewModel.isDeletePresented) {
                            Alert(
                                title: Text("Are you sure you want to delete this?"),
                                message: Text("You cannot undo this action once done."),
                                primaryButton: .destructive(Text("Delete")) {
                                        viewModel.delLoc()
                                        dismiss()
                                },
                                secondaryButton: .cancel()
                            )

                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .background(Color(.systemGroupedBackground))
                    
                    Spacer()
                }
                .frame(height: bottomDefaultHeight + 30)
            }
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    LocationDetailScreen(location: .preview)
}
