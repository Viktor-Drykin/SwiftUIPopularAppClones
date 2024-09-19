//
//  Product.swift
//  SwiftUISpotify
//
//  Created by Viktor Drykin on 15.08.2024.
//

import Foundation

// to get dummy json https://dummyjson.com/users
// to convert json into Swift struct https://app.quicktype.io

struct ProductList: Decodable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Decodable, Identifiable {
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let category: String?
    let tags: [String]
    let brand: String?
    let sku: String
    let weight: Int
    let warrantyInformation, shippingInformation: String
    let minimumOrderQuantity: Int
    let images: [String]
    let thumbnail: String
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}

extension Product {
    var firstImage: String {
        images.first ?? Constant.randomImage
    }

    static let mock: Product = .init(
        id: 123,
        title: "Example product title",
        description: "This is some mocked description",
        price: 999,
        discountPercentage: 12,
        rating: 4.5,
        stock: 50,
        category: "Electronic devices",
        tags: [],
        brand: "Apple",
        sku: "sku",
        weight: 2,
        warrantyInformation: "No warranty",
        shippingInformation: "No information",
        minimumOrderQuantity: 0,
        images: [Constant.randomImage, Constant.randomImage, Constant.randomImage],
        thumbnail: Constant.randomImage
    )
}
