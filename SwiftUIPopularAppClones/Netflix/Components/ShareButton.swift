//
//  ShareButton.swift
//  SwiftUIPopularAppClones
//
//  Created by Viktor Drykin on 15.10.2024.
//

import SwiftUI

struct ShareButton: View {

    var urlString: String = "https://www.google.com"

    var body: some View {
        if let url = URL(string: urlString) {
            ShareLink(item: url)  {
                VStack {
                    Image(systemName: "paperplane")
                        .font(.title)

                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(Color.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ShareButton()
    }
}
