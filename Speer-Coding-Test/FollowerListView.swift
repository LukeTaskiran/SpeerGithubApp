//
//  ProfileView.swift
//  Speer-Coding-Test
//
//  Created by Luke Taskiran on 2025-04-04.

import SwiftUI
struct FollowerListView: View {
    let username: String
    let isFollowers: Bool

    @State private var users: [GitHubUser] = []
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(users) { user in
                    NavigationLink(destination: ProfileView(username: user.login)) {
                        HStack {
                            AsyncImage(url: URL(string: user.avatar_url)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())

                            Text(user.login)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .navigationTitle(isFollowers ? "Followers" : "Following")
        .task {
            await fetchUsers()
        }
        .background(Color.purple.opacity(0.2))
    }

    private func fetchUsers() async {
        do {
            if isFollowers {
                users = try await GitHubService.shared.fetchFollowers(username: username)
            } else {
                users = try await GitHubService.shared.fetchFollowing(username: username)
            }
        } catch {
            print("Failed to load list: \(error)")
            errorMessage = "Failed to load users. Please try again later."
        }
    }
}
