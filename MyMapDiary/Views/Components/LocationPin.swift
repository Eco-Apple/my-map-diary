//
//  LocationPin.swift
//  MyMapDiary
//
//  Created by PNB0171M266 on 10/23/24.
//

import SwiftUI

struct LocationPin: View {
    @Environment(\.navigate) private var navigate
    
    var location: Location
    
    var body: some View {
        Button {
            navigate(.location(.detail(location)))
        } label: {
            VStack(spacing: 0) {
                Image(uiImage: location.uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                
                Triangle()
                    .fill(Color.white)
                    .frame(width: 13, height: 5)
            }
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
          path.move(to: CGPoint(x: rect.midX, y: rect.maxY)) // Bottom point of the triangle
          path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // Top right
          path.addLine(to: CGPoint(x: rect.minX, y: rect.minY)) // Top left
          path.closeSubpath()
          return path
    }
}
#Preview {
    LocationPin(location: .preview)
}
