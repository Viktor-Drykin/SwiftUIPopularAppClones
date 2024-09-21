//
//  BumbleHomeView.swift
//  SwiftUIPopularAppClones
//
//  Created by Viktor Drykin on 19.09.2024.
//

import SwiftUI
import SwiftfulUI

struct BumbleHomeView: View {

    @State private var filters: [String] = ["Everyone", "Tranding"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0
    @State private var cardOffsets: [Int: Bool] = [:] // UserID : (Direction is Right == true)
    @State private var currentSwipeOffset: CGFloat = 0

    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()

            VStack(spacing: 12) {
                header

                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)

                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { index, user in
                            let offsetValue = cardOffsets[user.id]
                            let isPrevious = (selectedIndex - 1) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            if isPrevious || isCurrent || isNext  {
                                userProfileCell(user: user, index: index)
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: offsetValue == nil ? 0 : offsetValue == true ? 1000 : -1000)
                            }
                        }
                    } else {
                        ProgressView()
                    }

                    overlaySwipingIndicators
                        .zIndex(9999)
                }
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffsets[user.id] = isLike

        selectedIndex += 1
    }

    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers = try await DatabaseHelper().getUsers()
        } catch {

        }
    }

    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {

                    }
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {

                    }

            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)

            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(Color.black.opacity(0.001))
                .onTapGesture {

                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }

    private func userProfileCell(user: User, index: Int) -> some View {
        BumbleCardView(
            onSuperLikePressed: nil,
            onXmarkPressed: {
                userDidSelect(index: index, isLike: false)
            },
            onCheckmarkPressed: {
                userDidSelect(index: index, isLike: true)
            },
            onSendAComplimentPressed: nil,
            onHideAndReportPressed: nil,
            user: user
        )
            .withDragGesture(
                .horizontal,
                minimumDistance: 10,
                resets: true,
                rotationMultiplier: 1.05,
                //scaleMultiplier: 0.8,
                onChanged: { dragOffset in
                    currentSwipeOffset = dragOffset.width
                },
                onEnded: { dragOffset in
                    if dragOffset.width < -50 {
                        userDidSelect(index: index, isLike: false)
                    } else if dragOffset.width > 50 {
                        userDidSelect(index: index, isLike: true)
                    }
                }
            )
    }

    private var overlaySwipingIndicators: some View {
        ZStack {
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)

            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1.0)
                .offset(x: max(-currentSwipeOffset, -150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .animation(.smooth, value: currentSwipeOffset)
    }
}

#Preview {
    BumbleHomeView()
}
