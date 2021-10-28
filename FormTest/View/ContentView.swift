//
//  ContentView.swift
//  FormTest
//
//  Created by Shuji Fukumoto on 2021/10/27.
//

import SwiftUI


struct ContentView: View {
	@StateObject var userStore = UserStore()
	@State private var currentUser: User?

	var body: some View {
		NavigationView {
			Group {
				if userStore.users.isEmpty {
					Text("No users")
						.foregroundColor(.secondary)
						.font(.title)
				} else {
					List {
						ForEach($userStore.users) { $user in
							NavigationLink(tag: user, selection: $currentUser) {
								UserView(user: $user)
							} label: {
								UserRow(user: user)
							}
						}
						.onDelete { indexSet in
							userStore.deleteUser(indexSet: indexSet)
						}
					}
				}
			}
			.navigationTitle(Text("Users"))
			.toolbar {
				Button(action: { addUser() }) { Image(systemName: "plus.circle") }
			}
		}
	}

	private func addUser() {
		let newUser = User(name: "New user", email: "", status: .bronze)
		userStore.add(user: newUser)
		currentUser = newUser
	}
}

// MARK: -

struct UserRow: View {
	@ObservedObject var user: User

	var body: some View {
		HStack {
			Text(user.name)
				.fontWeight(.black)
			Spacer()
			Text(user.status.rawValue.uppercased())
				.foregroundColor(.secondary)
				.font(.caption)
				.fontWeight(.bold)
		}
	}
}

// MARK: -

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
