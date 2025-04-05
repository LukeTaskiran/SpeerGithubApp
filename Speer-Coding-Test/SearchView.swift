//
//  SearchView.swift
//  Speer-Coding-Test
//
//  Created by Luke Taskiran on 2025-04-04.
//
import SwiftUI
struct SearchView: View {
    @State private var username: String = ""
    @State private var user: GitHubUser?
    @State private var notFound = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter GitHub username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button("Search") {
                    Task {
                        do {
                            user = try await GitHubService.shared.fetchUser(username: username)
                            notFound = false
                        } catch {
                            notFound = true
                            user = nil
                        }
                    }
                }

                if notFound {
                    Text("User not found 😞")
                        .foregroundColor(.red)
                }

                if let user = user {
                    NavigationLink(destination: ProfileView(user: user)) {
                        Text("View Profile for \(user.login)")
                    }
                }

                Spacer()
            }
            .navigationTitle("GitHub Search")
        }
    }
}
