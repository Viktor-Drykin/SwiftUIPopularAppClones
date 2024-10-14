//
//  NetflixDetailsView.swift
//  SwiftUIPopularAppClones
//
//  Created by Viktor Drykin on 14.10.2024.
//

import SwiftUI

struct NetflixDetailsView: View {

    var product: Product = .mock
    @State private var progress: Double = 0.2

    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()

            VStack(spacing: 0) {
                NetflixDetailsHeaderView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirplayPressed: {

                    },
                    onXMarkPressed: {

                    }
                )

                ScrollView(.vertical) {
                    VStack(spacing: 16) {
                        NetflixDetailsProductView(
                            title: product.title,
                            isNew: true,
                            yearReleased: "2024",
                            seasonCount: 4,
                            hasClosedCaptions: true,
                            isTop10: 6,
                            descriptionText: product.description,
                            castText: "Cast: Nick, Viktor and others",
                            onPlayPressed: {

                            },
                            onDownloadPressed: {

                            })

                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    NetflixDetailsView()
}
