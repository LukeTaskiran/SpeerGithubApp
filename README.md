GitHub Profile Viewer
This SwiftUI app allows users to search for and view GitHub user profiles, including details like their followers, following, and bio. The app fetches data directly from the GitHub API.

Features
Profile Display: Displays a user's profile information, such as their name, bio, avatar, followers, and following count.

Navigation: Navigate from the search screen to a user's profile and see their followers and following.

Error Handling: If the user is not found or an error occurs while fetching data, the app shows an error message.

How It Works
User Search: On the main screen, enter a GitHub username and press "Search." If the username exists, the app will show a button to navigate to the user's profile.

Profile Display: The profile screen shows the user's avatar, name, bio, and the number of followers and following. You can also navigate to a list of followers or following for the selected user.

Followers and Following List: Tap on the "Followers" or "Following" link to view a list of the user's followers or following. Each entry links to their GitHub profile.


<img src="https://github.com/user-attachments/assets/6b01f135-676c-4a89-a058-51380a07daee" width="150">
<img src="https://github.com/user-attachments/assets/e4318169-0be6-4b76-bd56-ec06e2239221" width="150">
<img src="https://github.com/user-attachments/assets/a65ac8e4-8ce7-45fc-ace8-5b1e3fa14bea" width="150">




GitHubService
The GitHubService class handles fetching user data from GitHub's API:

/users/{username}: Fetches the profile data for the given username.

/users/{username}/followers: Fetches the list of followers for the given username.

/users/{username}/following: Fetches the list of following for the given username.

Setup
Clone or download the project to your local machine.

Open the project in Xcode.

Run the app on a simulator or physical device.
