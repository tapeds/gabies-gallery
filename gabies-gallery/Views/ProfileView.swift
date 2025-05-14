// ProfileView.swift
// gabies-gallery
//
// Created by Farrell Matthew Lim on 07/05/25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var isZoomed: Bool
    @State private var showFloor = false
    @StateObject private var musicViewModel = MusicViewModel.shared

    var body: some View {
        GalleryView(item: MockData.ProfileData, width: 200, height: 200)
            .scaleEffect(isZoomed ? 1.3 : 0.5)
            .frame(alignment: .center)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring()) {
                    isZoomed.toggle()
                }
            }
            .padding(isZoomed ? 20 : 0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation {
                        showFloor = true
                    }
                }
            }
    }
}

#Preview {
    ProfileView(isZoomed: .constant(false))
}
