//
//  FilmViewModel.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 10/05/25.
//

import SwiftUI

final class FilmViewModel: ObservableObject {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0),
    ]

    let zoomedColumns: [GridItem] = [GridItem(.flexible(), spacing: 0)]

    @Published var selectedItem: Item?
}
