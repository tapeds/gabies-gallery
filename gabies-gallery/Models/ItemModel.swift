//
//  ItemModel.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 08/05/25.
//

import Foundation

struct Item: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let author: String?
    let description: String?
    let musicSearch: String?
    let imageName: String
}

struct MockData {
    static let EmptyData = Item(
        title: "Not Found",
        author: nil,
        description: nil,
        musicSearch: nil,
        imageName: ""
    )

    static let ProfileData = Item(
        title: "Gabriela Sihutomo",
        author: "",
        description:
            "Gabie loves music, movies, and gaming, with an interest in Korean culture. She's skilled in coding and passionate about makeup and skincare.",
        musicSearch: nil,
        imageName: "gabie"
    )

    static let MusicData = [
        Item(
            title: "Autumn",
            author: "NIKI",
            description: nil,
            musicSearch: "autumn niki",
            imageName: "autumn-niki"
        ),
        Item(
            title: "Drunk",
            author: "Keshi",
            description: nil,
            musicSearch: "drunk keshi",
            imageName: "drunk-keshi"
        ),
        Item(
            title: "Nobody Gets Me",
            author: "SZA",
            description: nil,
            musicSearch: "nobody gets me sza",
            imageName: "nobody-gets-me-sza"
        ),
        Item(
            title: "Moth To A Flame",
            author: "The Weeknd",
            description: nil,
            musicSearch: "moth to a flame the weeknd",
            imageName: "moth-to-a-flame-the-weeknd"
        ),
        Item(
            title: "Love.",
            author: "wave to earth",
            description: nil,
            musicSearch: "love wave to earth",
            imageName: "love-wave-to-earth"
        ),
        Item(
            title: "WINDFLOWER",
            author: "Billie Eilish",
            description: nil,
            musicSearch: "windflower billie eilish",
            imageName: "windflower-billie-eilish"
        ),
    ]

    static let FilmData = [
        Item(
            title: "Lovely Runner",
            author: nil,
            description: nil,
            musicSearch: nil,
            imageName: "lovely-runner"
        ),
        Item(
            title: "Black Panther",
            author: nil,
            description: nil,
            musicSearch: nil,
            imageName: "black-panther"
        ),
        Item(
            title: "Spiderman: No Way Home",
            author: nil,
            description: nil,
            musicSearch: nil,
            imageName: "spiderman-no-way-home"
        ),
        Item(
            title: "Moon Knight",
            author: nil,
            description: nil,
            musicSearch: nil,
            imageName: "moon-knight"
        ),
    ]
}
