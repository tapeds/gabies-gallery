// BackgroundView.swift
// gabies-gallery
//
// Created by Farrell Matthew Lim on 07/05/25.
//

import SwiftUI

struct WallView: View {
    var body: some View {
        Color(red: 249 / 255, green: 246 / 255, blue: 241 / 255).overlay(
            Image("wall-texture")
                .resizable()
                .opacity(0.3)
        )
        .ignoresSafeArea()
        .overlay(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.15), Color.clear,
                    Color.black.opacity(0.15),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .overlay(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.15), Color.clear,
                    Color.black.opacity(0.15),
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
    }
}

struct FloorView: View {
    var body: some View {
        Rectangle()
            .fill(Color(red: 178 / 255, green: 149 / 255, blue: 125 / 255))
            .frame(height: 100)
            .overlay(
                Image("floor-texture")
                    .resizable()
                    .opacity(0.3)
            )
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.25), Color.clear,
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        WallView()
        FloorView()
    }
    .edgesIgnoringSafeArea(.all)
}
