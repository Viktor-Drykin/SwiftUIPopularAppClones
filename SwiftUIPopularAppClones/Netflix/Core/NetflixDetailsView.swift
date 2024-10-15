//
//  NetflixDetailsView.swift
//  SwiftUIPopularAppClones
//
//  Created by Viktor Drykin on 14.10.2024.
//

import SwiftUI
import SwiftfulRouting

struct NetflixDetailsView: View {

    @Environment(\.router) var router

    var product: Product = .mock
    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var products: [Product] = []

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
                        router.dismissScreen()
                    }
                )

                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        detailsProductSection
                        buttonsSection
                        productsGridSection
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var detailsProductSection: some View {
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

    private var buttonsSection: some View {
        HStack(spacing: 32) {
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }

            RateButton { selection in
                // do something with selection
            }

            ShareButton()
        }
        .padding(.leading, 32)
    }

    private var productsGridSection: some View {
        VStack(alignment: .leading) {
            Text("More like this")
                .font(.headline)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3),
                      alignment: .center,
                      spacing: 8,
                      pinnedViews: [],
                      content: {
                ForEach(products) { product in
                    NetflixMovieCell(
                        imageName: product.firstImage,
                        title: product.title,
                        isRecentlyAdded: product.recentlyAdded,
                        topRanking: nil
                    )
                    .onTapGesture {
                        onProductPressed(product: product)
                    }
                }
            })
        }
        .foregroundStyle(.netflixWhite)
    }

    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixDetailsView(product: product)
        }
    }

    private func getData() async {
        guard products.isEmpty else { return }
        do {
            products = try await Array(DatabaseHelper().getProducts())

        } catch {

        }
    }
}

#Preview {
    RouterView { _ in
        NetflixDetailsView()
    }
}
