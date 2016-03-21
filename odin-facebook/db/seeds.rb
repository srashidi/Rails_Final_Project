# Users

User.create!(	name: "Example User",
							username: "exampleuser",
							email: "example@odinfacebook.com",
							password: "password",
							password_confirmation: "password")

99.times do |n|
	name = Faker::Name.name
	username = "exampleuser#{n+1}"
	email = "example-#{n+1}@odinfacebook.com"
	password = "password"
	User.create!(	name: name,
								username: username,
								email: email,
								password: password,
								password_confirmation: password)
end