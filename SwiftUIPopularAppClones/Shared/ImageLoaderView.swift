//
//  ImageLoaderView.swift
//  SwiftUISpotify
//
//  Created by Viktor Drykin on 15.08.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {

    var urlString = Constant.randomImage
    var resizingMode: ContentMode = .fill

    var body: some View {
        Rectangle()
            .opacity(0.0001)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(40)
        .padding(.vertical, 60)
}
