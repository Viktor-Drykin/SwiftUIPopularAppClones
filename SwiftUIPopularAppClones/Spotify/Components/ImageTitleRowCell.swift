//
//  ImageTitleRowCell.swift
//  SwiftUISpotify
//
//  Created by Viktor Drykin on 16.08.2024.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constant.randomImage
    var title: String = "Some item name"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(height: imageSize)
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        ImageTitleRowCell()
            .padding()
    }
}
