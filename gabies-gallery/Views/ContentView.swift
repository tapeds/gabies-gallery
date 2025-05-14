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

    enum GalleryView: Int, CaseIterable {
        case film = 0
        case profile = 1
        case music = 2
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
                .transition(.opacity)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct GalleryContainerView: View {
    @Binding var currentView: ContentView.GalleryView
    @Binding var isZoomed: Bool

    var body: some View {
        TabView(selection: $currentView) {
            FilmView(isZoomed: $isZoomed)
                .tag(ContentView.GalleryView.film)

            ProfileView(isZoomed: $isZoomed)
                .tag(ContentView.GalleryView.profile)

            MusicView(isZoomed: $isZoomed)
                .tag(ContentView.GalleryView.music)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .offset(y: isZoomed ? 0 : -30)
    }
}

#Preview {
    ContentView()
}
