//
//  MusicViewModel.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 08/05/25.
//

import MusicKit
import SwiftUI

struct PreloadedSong {
    let song: Song
    let item: Item
}

@MainActor
final class MusicViewModel: ObservableObject {
    static let shared = MusicViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0),
    ]

    let zoomedColumns: [GridItem] = [GridItem(.flexible(), spacing: 0)]
    let player = ApplicationMusicPlayer.shared

    @Published var selectedItem: Item?

    @Published var preloadedSongs: [PreloadedSong] = []

    private init() {
        Task {
            await preloadSongs()
        }
    }

    private func preloadSongs() async {
        do {
            let status = await MusicAuthorization.request()
            guard status == .authorized else {
                print("Not authorized")
                return
            }

            var loadedSongs: [PreloadedSong] = []

            for music in MockData.MusicData {
                if let songSearch = music.musicSearch, !songSearch.isEmpty {
                    var request = MusicCatalogSearchRequest(
                        term: songSearch,
                        types: [Song.self]
                    )
                    request.limit = 1

                    let response = try await request.response()

                    if let song = response.songs.first {
                        let preloadedSong = PreloadedSong(
                            song: song,
                            item: music
                        )
                        loadedSongs.append(preloadedSong)
                    }
                }
            }

            DispatchQueue.main.async {
                self.preloadedSongs = loadedSongs
            }
        } catch {
            print("Error preloading songs: \(error)")
        }
    }

    func playSong() async {
        do {
            try await player.play()
        } catch {
            print("error")
        }
    }

    func stopSong() {
        player.stop()
    }

    func searchAndPlaySong(songSearch: String) async {
        if let preloadedSong = preloadedSongs.first(where: {
            $0.item.musicSearch == songSearch
        }) {
            player.queue = ApplicationMusicPlayer.Queue(for: [
                preloadedSong.song
            ])
            await playSong()
        }
    }
}
