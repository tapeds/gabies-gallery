// ContentView.swift
// gabies-gallery
//
// Created by Farrell Matthew Lim on 07/05/25.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    @StateObject var viewModel = BackgroundViewModel()
    let hideFloor: Bool
    let content: () -> Content
    
    init(hideFloor: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.hideFloor = hideFloor
        self.content = content
    }
    
    var body: some View {
        ZStack {
            SceneBackground(viewModel: viewModel, hideFloor: hideFloor)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}

struct SceneBackground: View {
    let viewModel: BackgroundViewModel
    let hideFloor: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WallView()
            if !hideFloor {
                FloorView(viewModel: viewModel)
            }
        }
    }
}

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
    }
}

struct FloorView: View {
    let viewModel: BackgroundViewModel

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
    BackgroundView {
        Text("Test Background View")
    }
}
