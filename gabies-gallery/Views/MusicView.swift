//
//  MusicView.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 07/05/25.
//

import SwiftUI

struct MusicView: View {
    @StateObject private var viewModel = MusicViewModel.shared
    @Binding var isZoomed: Bool
    @State private var zoomedItem: Item? = nil

    var body: some View {
        LazyVGrid(
            columns: zoomedItem != nil
                ? viewModel.zoomedColumns
                : viewModel.columns,
            alignment: .center
        ) {
            ForEach(MockData.MusicData) { music in
                if zoomedItem == nil || zoomedItem?.id == music.id {
                    MusicItemView(
                        music: music,
                        isZoomed: zoomedItem != nil,
                        isSelected: zoomedItem?.id == music.id
                    ) {
                        if zoomedItem?.id == music.id {
                            viewModel.stopSong()
                            withAnimation(.spring) {
                                zoomedItem = nil
                            }
                            DispatchQueue.main.asyncAfter(
                                deadline: .now() + 0.15
                            ) {
                                withAnimation(.spring) {
                                    isZoomed = false
                                }
                            }
                        } else {
                            guard zoomedItem == nil && !isZoomed else {
                                return
                            }

                            withAnimation(.spring) {
                                zoomedItem = music
                                isZoomed = true
                            }
                            Task {
                                await viewModel.searchAndPlaySong(
                                    songSearch: music.musicSearch ?? ""
                                )
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .onChange(of: isZoomed) { oldValue, newValue in
            if newValue == false {
                viewModel.stopSong()
            }
        }
    }
}

struct MusicItemView: View {
    let music: Item
    let isZoomed: Bool
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        GalleryView(item: music, width: 200, height: 200)
            .scaleEffect(isSelected ? 1.3 : 0.5)
            .frame(
                width: isSelected ? 220 : 180,
                height: isSelected ? 300 : 170
            )
            .frame(maxWidth: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .onTapGesture(perform: onTap)
            .animation(.spring, value: isSelected)
    }
}

#Preview {
    MusicView(isZoomed: .constant(false))
}
