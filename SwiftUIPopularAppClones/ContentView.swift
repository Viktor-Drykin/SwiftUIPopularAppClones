//
//  ContentView.swift
//  SwiftUISpotify
//
//  Created by Viktor Drykin on 15.08.2024.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {

    @Environment(\.router) var router

    @State private var users: [User] = []
    @State private var products: [Product] = []

    var body: some View {
        List {
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
                }
            }
            Button("Open Bumble") {
                router.showScreen(.fullScreenCover) { _ in
                    BumbleHomeView()
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
