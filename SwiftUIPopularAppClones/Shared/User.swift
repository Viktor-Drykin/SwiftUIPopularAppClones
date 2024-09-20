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

extension User {
    var work: String { "Worker as Some Job" }
    var education: String { "Graduate Degree" }
    var aboutMe: String { "This is a sentence about me to look good in my profile" }
    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
            UserInterest(iconName: "graduationcap", emoji: nil, text: "\(education)"),
            UserInterest(iconName: "wineglass", emoji: nil, text: "Socially"),
            UserInterest(iconName: "moon.stars.fill", emoji: nil, text: "Virgo")
        ]
    }
    var interests: [UserInterest] {
        [
            UserInterest(iconName: nil, emoji: "🥳", text: "Running"),
            UserInterest(iconName: nil, emoji: "🥶", text: "Gym"),
            UserInterest(iconName: nil, emoji: "🤥", text: "Music"),
            UserInterest(iconName: nil, emoji: "😡", text: "Cooking")
        ]
    }

    var images: [String] {
        ["https://picsum.photos/500/500", "https://picsum.photos/600/600", "https://picsum.photos/700/700"]
    }
}

