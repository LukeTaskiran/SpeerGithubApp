//
//  ProfileView.swift
//  Speer-Coding-Test
//
//  Created by Luke Taskiran on 2025-04-04.
//
import SwiftUI
struct ProfileView: View {
    let user: GitHubUser

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: user.avatar_url)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    ProgressView()
                }
            }

            Text(user.name ?? user.login)
                .font(.title2)
                .bold()

            Text(user.bio ?? "")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

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
        .navigationTitle(user.login)
    }
}
