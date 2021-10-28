//
//  UserView.swift
//  FormTest
//
//  Created by Shuji Fukumoto on 2021/10/28.
//

import SwiftUI


struct UserView: View {
	@Binding var user: User

	@State private var name: String = "name default value"
	@State private var email: String = "email default value"
	@State private var status: User.Status = .bronze

	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		Form {
			Section(footer: Text("Correct value is not shown until tap the field.")) {
				TextField("Name", text: $name)
				TextField("Email", text: $email)
			}

			Section(footer: Text("This must be DefaultPickerStyle for support many options. But this cause onAppear event when select and return to this form...")) {
				Picker("Status", selection: $status) {
					ForEach(User.Status.allCases, id: \.self) {
						Text($0.rawValue.uppercased())
					}
				}
				.pickerStyle(DefaultPickerStyle())
			}

			Section(header: Text("Problems and Required")) {
				VStack(alignment: .leading, spacing: 16) {
					Text("Correct value for name and email is not shown until tap the field.")

					Text("Tap Status and select one. But Status is neve changed. Because onApear reset the values.")

					Text("Never update the data till user tap Save button. Thus, can't pass $user.name directly to the field. User is a class not a struct.")

					Text("If this is new user, delete this data if the user doesn't tap save button. This is not implemented. How? User class needs 'newUser' flag?")
				}
			}
			.foregroundColor(Color(.systemRed))

		}
		.navigationTitle("Edit user")
		.toolbar {
			Button("Save") {
				user.name = name
				user.email = email
				presentationMode.wrappedValue.dismiss()
			}
		}
		.onAppear {
			name = user.name
			email = user.email
			status = user.status
		}
	}
}

// MARK: -

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
		UserView(user: .constant(User(name: "Shuji", email: "shuji@abc.com", status: .gold)))
    }
}
