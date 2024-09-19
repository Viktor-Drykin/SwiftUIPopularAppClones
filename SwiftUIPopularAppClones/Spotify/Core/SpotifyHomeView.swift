//
//  SpotifyHomeView.swift
//  SwiftUISpotify
//
//  Created by Viktor Drykin on 15.08.2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {

    @Environment(\.router) var router

    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []

    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {

                        VStack {
                            recentSection
                                .padding(.horizontal, 16)

                            if let product = products.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 16)
                            }

                            listRows
                        }
                    } header: {
                        header
                    }
                }
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 35, height: 35)

            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .frame(maxWidth: .infinity)
        .background(Color.spotifyBlack)
    }

    private var recentSection: some View {
        NonLazyVGrid(
            columns: 2,
            alignment: .center,
            spacing: 20,
            items: products) { product in
                if let product {
                    SpotifyRecentsCell(
                        imageName: product.firstImage, title: product.title
                    )
                    .asButton(.press) {
                        goToPlaylistView(product: product)
                    }

                }
            }
    }

    private func goToPlaylistView(product: Product) {
        guard let currentUser else { return }
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: currentUser)
        }
    }

    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {
                
            },
            onPlayPressed: {
                goToPlaylistView(product: product)
            }
        )
    }

    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageSize: 120,
                                imageName: product.firstImage,
                                title: product.title
                            )
                            .asButton(.press) {
                                goToPlaylistView(product: product)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }

    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(upTo: 8))

            var rows: [ProductRow] = []
            let allBrands = Set(products.compactMap { $0.brand })
            for brand in allBrands {
                //let products = self.products.filter { $0.brand == brand }
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRows = rows
        } catch {

        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyHomeView()
    }
}
