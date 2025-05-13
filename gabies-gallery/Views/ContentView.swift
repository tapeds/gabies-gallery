//
//  ContentView.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 09/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showGallery = false
    @State private var isZoomed = false
    @State private var currentView: GalleryView = .profile

    enum GalleryView {
        case profile
        case music
        case film
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            WallView()

            if !isZoomed {
                FloorView()
                    .transition(.opacity)
            }

            if !showGallery {
                HomeView(showGallery: $showGallery)
                    .transition(
                        .asymmetric(
                            insertion: .scale(scale: 1)
                                .combined(with: .opacity)
                                .animation(
                                    .spring(response: 0.6, dampingFraction: 0.8)
                                ),
                            removal: .scale(scale: 0.95)
                                .animation(.easeOut(duration: 0.2))
                        )
                    )
            } else {
                GalleryContainerView(
                    currentView: $currentView,
                    isZoomed: $isZoomed
                )
                .transition(
                    .asymmetric(
                        insertion: .scale(scale: 0.95)
                            .animation(
                                .spring()
                            ),
                        removal: .opacity
                            .animation(.easeOut(duration: 0.3))
                    )
                )
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct GalleryContainerView: View {
    @Binding var currentView: ContentView.GalleryView
    @Binding var isZoomed: Bool

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                FilmView(isZoomed: $isZoomed)
                    .frame(width: geometry.size.width)
                    .frame(maxHeight: .infinity)

                ProfileView(isZoomed: $isZoomed)
                    .frame(width: geometry.size.width)
                    .frame(maxHeight: .infinity)

                MusicView(isZoomed: $isZoomed)
                    .frame(width: geometry.size.width)
                    .frame(maxHeight: .infinity)

            }
            .offset(
                x: currentView == .profile
                    ? -geometry.size.width
                    : currentView == .film ? 0 : -2 * geometry.size.width
            )
            .animation(.spring(), value: currentView)
            .gesture(
                DragGesture()
                    .onEnded { gesture in
                        if !isZoomed {
                            if gesture.translation.width < -50
                                && currentView == .profile
                            {
                                currentView = .music
                            } else if gesture.translation.width > 50
                                && currentView == .profile
                            {
                                currentView = .film
                            } else if gesture.translation.width < -50
                                && currentView == .film
                            {
                                currentView = .profile
                            } else if gesture.translation.width > 50
                                && currentView == .music
                            {
                                currentView = .profile
                            }
                        }
                    }
            )
        }
        .padding(.bottom, isZoomed ? 0 : 20)
    }
}

#Preview {
    ContentView()
}
