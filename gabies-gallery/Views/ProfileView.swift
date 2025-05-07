// ProfileView.swift
// gabies-gallery
//
// Created by Farrell Matthew Lim on 07/05/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var isZoomed = false
    
    var body: some View {
        BackgroundView(hideFloor: isZoomed) {
            VStack(alignment: .trailing, spacing: 6) {
                FrameView(imageName: "pencil", width: 200, height: 200)
                DescriptionView(
                    title: "Gabriela Putri Jelita Sihutomo",
                    description: "M10"
                )
            }
            .scaleEffect(isZoomed ? 1.3 : 0.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: isZoomed ? .center : .center)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring()) {
                    isZoomed.toggle()
                }
            }
            .padding(isZoomed ? 20 : 0)
        }
    }
}

struct FrameView: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: width, height: height)
            .padding(20)
            .background(Color.white)
            .padding(5)
            .background(Color.brown)
            .cornerRadius(2)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 4, y: 4)
    }
}

struct DescriptionView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.black)
            
            Text(description)
                .font(.system(size: 6))
                .foregroundColor(.gray)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: 100)
        .padding(8)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 2)
        .padding(.trailing, 5)
    }
}

#Preview {
    ProfileView()
}
