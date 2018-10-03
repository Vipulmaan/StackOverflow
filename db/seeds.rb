# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

20.times do
  salt=BCrypt::Engine.generate_salt
  name=Faker::Name.first_name
  email=Faker::Internet.free_email
  password=Faker::Internet.password
  password_digest=BCrypt::Engine.hash_secret(password,salt),

  User.create!(
          name:name ,
          email:email ,
          reputation: 0,
          salt: salt,
          encrypted_password: password_digest,
          password:password,
          password_confirmation:password
  )
end

#Questions

5.times do
  users = User.order(:created_at).take(10)
  users.each do |user|
    question = Faker::Lorem.question
    body = Faker::Lorem.paragraph
    user.questions.create!(title: question, body: body)
  end
end

# #Answers

questions = Question.order(:created_at).take(40)
users = User.order(:created_at).take(10)
questions.each do |question|
  users.each do |user|
    answer = Faker::Lorem.paragraph
    user.answers.create!(description: answer, question_id: question.id)
  end
end


#Comments

questions = Question.order(:created_at).take(40)
users = User.order(:created_at).take(10)
answers = Answer.order(:created_at).take(70)
questions.each do |question|
  users.each do |user|
    comment = Faker::Lorem.sentence
    question.comments.create!(description: comment, user_id: user.id)
  end
end
answers.each do |answer|
  users.each do |user|
    comment = Faker::Lorem.sentence
    answer.comments.create!(description: comment, user_id: user.id)
  end
end


#Available Tags

20.times do
  tag_name = Faker::Lorem.word
  AvailableTag.where(name: tag_name).first_or_create
end

10.times do 
  users = User.order(:created_at).take(10)
  questions = Question.order(:created_at).take(40)
  users.each do |user|
     tag_name = Faker::Lorem.word
   available_tag=AvailableTag.where(name: tag_name).first_or_create
   user.tags.where(available_tags_id: available_tag.id).first_or_create
   end

questions.each do |question|
    tag_name = Faker::Lorem.word
    available_tag=AvailableTag.where(name: tag_name).first_or_create
   question.tags.where(available_tags_id: available_tag.id).first_or_create
end
end 




#
# #votes
#
# users = User.order(:created_at).take(20)
# questions = Question.order(:created_at).take(40)
# answers = Answer.order(:created_at).take(10)
# users.each do |user|
#   vote_type = rand(2)
#   questions.each do |question|
#     question.votes.create!(user_id: user.id,vote_type: vote_type)
#   end
#   answers.each do |answer|
#     answer.votes.create!(user_id: user.id,vote_type: vote_type)
#   end
# end
