//
//  MusicView.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 07/05/25.
//

import SwiftUI

struct MusicView: View {
    @StateObject var viewModel = MusicViewModel()
    @Binding var isZoomed: Bool
    @State private var zoomedItem: Item? = nil
    @State private var disableClick: Bool = false

    var body: some View {
        LazyVGrid(
            columns: zoomedItem != nil
                ? viewModel.zoomedColumns : viewModel.columns,
            alignment: .center
        ) {
            ForEach(MockData.MusicData) { music in
                if zoomedItem == nil || zoomedItem?.id == music.id {
                    MusicItemView(
                        music: music,
                        isZoomed: zoomedItem != nil,
                        isSelected: zoomedItem?.id == music.id
                    ) {
                        withAnimation(.spring()) {
                            if !disableClick {
                                if zoomedItem?.id == music.id {
                                    viewModel.stopSong()
                                    disableClick = true
                                    zoomedItem = nil
                                    isZoomed = false
                                    Task {
                                        DispatchQueue.main.asyncAfter(
                                            deadline: .now() + 0.3
                                        ) {
                                            disableClick = false
                                        }
                                    }
                                } else if !isZoomed {
                                    disableClick = true
                                    zoomedItem = music
                                    isZoomed = true
                                    Task {
                                        DispatchQueue.main.asyncAfter(
                                            deadline: .now() + 0.3
                                        ) {
                                            disableClick = false
                                        }
                                        await viewModel.searchAndPlaySong(
                                            songSearch: music.musicSearch ?? ""
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
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
                width: isSelected ? 50 : 180,
                height: isSelected ? 420 : 170
            )
            .frame(maxWidth: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .onTapGesture(perform: onTap)
    }
}

#Preview {
    MusicView(isZoomed: .constant(false))
}
