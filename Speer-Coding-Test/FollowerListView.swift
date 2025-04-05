import SwiftUI

struct FollowerListView: View {
    let username: String
    let isFollowers: Bool

    @State private var users: [GitHubUser] = []

    var body: some View {
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
                }
            }
        }
        .navigationTitle(isFollowers ? "Followers" : "Following")
        .task {
            do {
                users = try await (isFollowers
                    ? GitHubService.shared.fetchFollowers(username: username)
                    : GitHubService.shared.fetchFollowing(username: username))
            } catch {
                print("Failed to load list")
            }
        }
    }
}
