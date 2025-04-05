//
//  GitHubService.swift
//  Speer-Coding-Test
//
//  Created by Luke Taskiran on 2025-04-04.
//

import SwiftUI
struct GitHubUser: Codable, Identifiable {
    let id: Int
    let login: String
    let avatar_url: String
    let name: String?
    let bio: String?
    let followers: Int
    let following: Int
}

class GitHubService {
    static let shared = GitHubService()

    func fetchUser(username: String) async throws -> GitHubUser {
        let url = URL(string: "https://api.github.com/users/\(username)")!
        let (data, response) = try await URLSession.shared.data(from: url)

        if let http = response as? HTTPURLResponse, http.statusCode == 404 {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(GitHubUser.self, from: data)
    }

    func fetchFollowers(username: String) async throws -> [GitHubUser] {
        let url = URL(string: "https://api.github.com/users/\(username)/followers")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([GitHubUser].self, from: data)
    }

    func fetchFollowing(username: String) async throws -> [GitHubUser] {
        let url = URL(string: "https://api.github.com/users/\(username)/following")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([GitHubUser].self, from: data)
    }
}
