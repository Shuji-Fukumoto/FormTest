//
//  User.swift
//  FormTest
//
//  Created by Shuji Fukumoto on 2021/10/28.
//

import Foundation


final class User: ObservableObject, Identifiable {
	enum Status: String, CaseIterable {
		case bronze, silver, gold
	}

	let id = UUID().uuidString

	// These property is not have to be @Published, but my another app needs so.
	@Published var name: String
	@Published var email: String
	@Published var status: Status

	init(name: String, email: String, status: Status) {
		self.name = name
		self.email = email
		self.status = status
	}

}

// MARK: -

extension User: Hashable {
	static func == (lhs: User, rhs: User) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
