# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

5.times do |i|
  User.create(name: "asdf#{i}", email: "example-#{i + 1}@railstutorial.org", encrypted_password: "asdf-#{i}", salt: "qwer-#{i}")
end

# 100.times do
#   salt=BCrypt::Engine.generate_salt
#   name=Faker::Name.name
#   email=Faker::Internet.free_email
#   password=Faker::Internet.password
#   password_digest=BCrypt::Engine.hash_secret(password,salt),
#
#   User.create!(
#           name:name ,
#           email:email ,
#           reputation: 0,
#           salt: salt,
#           encrypted_password: password_digest,
#           password:password,
#           password_confirmation:password
#   )
# end
