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

# Friendships

20.times do |n|
	to_id = n+1
	Friendship.create!( from_id: 1,
											to_id: to_id,
											accepted: true,
											accepted_time: Time.now)
	to_id = n+25
	Friendship.create!( from_id: 1,
											to_id: to_id,
											accepted: false)
	from_id = n+50
	Friendship.create!( from_id: from_id,
											to_id: 1,
											accepted: true)
	from_id = n+75
	Friendship.create!( from_id: from_id,
											to_id: 1,
											accepted: false)
end

# Posts

ids = []
50.times do
	10.times do
		id = rand(100)+1
		ids << id unless ids.include?(id)
	end
	users = User.find(ids)
	message = Faker::Lorem.sentence(5)
	users.each { |user| user.posts.create!(message: message) }
end