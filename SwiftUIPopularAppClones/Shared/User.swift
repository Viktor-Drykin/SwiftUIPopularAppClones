//
//  User.swift
//  SwiftUISpotify
//
//  Created by Viktor Drykin on 15.08.2024.
//

import Foundation

// to get dummy json https://dummyjson.com/users
// to convert json into Swift struct https://app.quicktype.io

struct UserList: Decodable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Decodable, Identifiable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let height, weight: Double
    let eyeColor: String
    let ip: String
    let macAddress, university: String
    let ein, ssn, userAgent: String

    static let mock: User = .init(
        id: 444,
        firstName: "FirstName",
        lastName: "LastName",
        maidenName: "",
        age: 44,
        email: "ertwert@ertwerw.com",
        phone: "",
        username: "UserName",
        password: "Password",
        birthDate: "",
        image: Constant.randomImage,
        bloodGroup: "",
        height: 180,
        weight: 60,
        eyeColor: "",
        ip: "",
        macAddress: "",
        university: "",
        ein: "",
        ssn: "",
        userAgent: ""
    )
}

