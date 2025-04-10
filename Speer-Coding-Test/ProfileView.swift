//
//  ProfileView.swift
//  Speer-Coding-Test
//
//  Created by Luke Taskiran on 2025-04-04.
import SwiftUI

struct ProfileView: View {
    let username: String

    @State private var user: GitHubUserProfile? // Use GitHubUserProfile instead of GitHubUser
    @State private var isLoading = true
    @State private var showError = false

    var body: some View {
        Group {
            if let user = user {
                content(for: user)
                    .redacted(reason: isLoading ? .placeholder : [])
                    .animation(.easeInOut(duration: 0.3), value: isLoading)
            } else if showError {
                Text("User not found.")
                    .foregroundColor(.red)
            } else {
                ProgressView()
            }
        }
        .task {
            await fetchUser()
        }
        .navigationTitle(username)
    }

    @ViewBuilder
    private func content(for user: GitHubUserProfile) -> some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: user.avatar_url)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 100)
                }
            }

            Text(user.name ?? user.login)
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Text(user.bio ?? "")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.white)

            HStack(spacing: 40) {
                NavigationLink("\(user.followers) Followers") {
                    FollowerListView(username: user.login, isFollowers: true)
                }

                NavigationLink("\(user.following) Following") {
                    FollowerListView(username: user.login, isFollowers: false)
                }
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.8))
                .shadow(radius: 10)
        )
        .padding(.horizontal)
    }

    private func fetchUser() async {
        isLoading = true
        do {
            // Fetch the profile using GitHubUserProfile
            let fetchedUser = try await GitHubService.shared.fetchUser(username: username)
            self.user = fetchedUser
            try? await Task.sleep(nanoseconds: 1_200_000_000) // simulate skeleton loading (1.2s)
            isLoading = false
        } catch {
            showError = true
        }
    }
}
