//
//  FilmView.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 10/05/25.
//

import SwiftUI

struct FilmView: View {
    @StateObject var viewModel = FilmViewModel()
    @Binding var isZoomed: Bool
    @State private var zoomedItem: Item? = nil

    var body: some View {
        LazyVGrid(
            columns: zoomedItem != nil
                ? viewModel.zoomedColumns : viewModel.columns,
            alignment: .center
        ) {
            ForEach(MockData.FilmData) { film in
                if zoomedItem == nil || zoomedItem?.id == film.id {
                    GalleryView(item: film, width: 250, height: 358)
                        .scaleEffect(
                            zoomedItem?.id == film.id ? 1.2 : 0.5
                        )
                        .frame(
                            width: zoomedItem?.id == film.id
                                ? 200 : 100,
                            height: zoomedItem?.id == film.id
                                ? 550 : 250
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if zoomedItem == nil || zoomedItem?.id == film.id {
                                withAnimation(
                                    .spring()
                                ) {
                                    if zoomedItem?.id == film.id {
                                        zoomedItem = nil
                                        isZoomed = false
                                    } else {
                                        guard zoomedItem == nil && !isZoomed
                                        else {
                                            return
                                        }
                                        zoomedItem = film
                                        isZoomed = true
                                    }
                                }
                            }
                        }
                        .padding(zoomedItem?.id == film.id ? 20 : 0)
                }
            }
        }
        .padding()
    }
}

#Preview {
    FilmView(isZoomed: .constant(false))
}
