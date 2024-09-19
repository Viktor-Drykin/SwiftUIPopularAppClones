//
//  PlaylistHeaderCell.swift
//  SwiftUISpotify
//
//  Created by Viktor Drykin on 16.08.2024.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {

    var height: CGFloat = 300
    var title: String = "Some playlist title goes here"
    var subtitle: String = "Some playlist subtitle goes here"
    var imageName: String = Constant.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.8)

    var body: some View {
        ImageLoaderView(urlString: imageName)
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(subtitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                    .foregroundStyle(.spotifyWhite)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(colors: [shadowColor.opacity(0), shadowColor], startPoint: .top, endPoint: .bottom)
                    )
            }
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()

        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}
