//
//  GalleryView.swift
//  gabies-gallery
//
//  Created by Farrell Matthew Lim on 11/05/25.
//

import SwiftUI

struct GalleryView: View {
    let item: Item
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            FrameView(imageName: item.imageName, width: width, height: height)
            DescriptionView(
                title: item.title,
                author: item.author,
                description: item.description
            )
        }
    }
}

struct FrameView: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: width, height: height)
            .padding(20)
            .background(Color.white)
            .padding(5)
            .background(Color.brown)
            .cornerRadius(2)
            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 4, y: 4)
    }
}

struct DescriptionView: View {
    let title: String
    let author: String?
    let description: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.black)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)

            if let author = author, !author.isEmpty {
                Text(author)
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }

            if let description = description, !description.isEmpty {
                Text(description)
                    .font(.system(size: 6))
                    .foregroundStyle(Color.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .frame(width: 100, alignment: .leading)
        .padding(10)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 2)
    }
}
