//
//  UserStore.swift
//  FormTest
//
//  Created by Shuji Fukumoto on 2021/10/28.
//

import SwiftUI


final class UserStore: ObservableObject {
	@Published var users: [User] = []

	init() {
		// Sample data
		add(user: User(name: "Bill Atkinson", email: "Bill@apple.com", status: .gold))
		add(user: User(name: "Andy Hertzfeld", email: "Andy@apple.com", status: .silver))
	}

	func add(user: User) {
		users.append(user)
	}

	func deleteUser(indexSet: IndexSet) {
		users.remove(atOffsets: indexSet)
	}
}
