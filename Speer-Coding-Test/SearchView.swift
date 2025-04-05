//
//  ProfileView.swift
//  Speer-Coding-Test
//
//  Created by Luke Taskiran on 2025-04-04.

import SwiftUI

struct SearchView: View {
    @State private var username: String = ""
    @State private var userExists: Bool = false
    @State private var notFound = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter GitHub username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .shadow(radius: 5)

                Button(action: {
                    Task {
                        do {
                            _ = try await GitHubService.shared.fetchUser(username: username)
                            userExists = true
                            notFound = false
                        } catch {
                            notFound = true
                            userExists = false
                        }
                    }
                }) {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(userExists ? Color.blue : Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .font(.headline)
                }

                if notFound {
                    Text("User not found 😞")
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .italic()
                }

                if userExists {
                    NavigationLink(destination: ProfileView(username: username)) {
                        Text("View Profile for \(username)")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                }

                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationTitle("GitHub Search")
        }
    }
}
