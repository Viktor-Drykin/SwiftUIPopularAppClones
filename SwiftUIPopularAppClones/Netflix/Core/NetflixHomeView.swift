//
//  NetflixHomeView.swift
//  SwiftUIPopularAppClones
//
//  Created by Viktor Drykin on 21.09.2024.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {

    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []


    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()

            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)

                    if let heroProduct {
                        NetflixHeroCell(
                            imageName: heroProduct.firstImage,
                            isNetflixFilm: true,
                            title: heroProduct.title,
                            categories: [heroProduct.category?.capitalized, heroProduct.brand].compactMap { $0 }) {

                            } onPlayPressed: {

                            } onMyListPressed: {

                            }
                            .padding(24)

                    }

                    ForEach(0..<20) { _ in
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: 200)
                    }
                }
            }
            .scrollIndicators(.hidden)

            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 16)

                NetflixFilterBarView(
                    filters: filters,
                    selectedFilter: selectedFilter,
                    onFilterPressed: { newFilter in
                        selectedFilter = newFilter
                    },
                    onXmarkPressed: {
                        selectedFilter = nil
                    }
                )
                .padding(.top, 16)
            }
            .readingFrame { frame in
                fullHeaderSize = frame.size
            }
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)

            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {

                    }

                Image(systemName: "magnifyingglass")
                    .onTapGesture {

                    }
            }
            .font(.title2)
        }
    }

    private func getData() async {
        guard productRows.isEmpty else { return }

        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await Array(DatabaseHelper().getProducts())
            heroProduct = products.first

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
    NetflixHomeView()
}
