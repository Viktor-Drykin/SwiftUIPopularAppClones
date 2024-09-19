//
//  SpotifyCategoryCell.swift
//  SwiftUISpotify
//
//  Created by Viktor Drykin on 15.08.2024.
//

import SwiftUI

struct SpotifyCategoryCell: View {

    var title = "All"
    var isSelected = false

    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 36)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColors(isSelected: isSelected)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

extension View {

    func themeColors(isSelected: Bool) -> some View  {
        self
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()

        VStack(spacing: 40) {
            SpotifyCategoryCell(title: "Category")
            SpotifyCategoryCell(title: "Category Two", isSelected: true)
            SpotifyCategoryCell(isSelected: true)
        }
    }
}
