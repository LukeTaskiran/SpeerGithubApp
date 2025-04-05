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

                Button("Search") {
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
                }

                if notFound {
                    Text("User not found 😞")
                        .foregroundColor(.red)
                }

                if userExists {
                    NavigationLink(destination: ProfileView(username: username)) {
                        Text("View Profile for \(username)")
                    }
                }

                Spacer()
            }
            .navigationTitle("GitHub Search")
        }
    }
}
