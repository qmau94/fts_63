# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create! username: "Admin", email: "admin@gmail.com",
  password: "1", password_confirmation: "1", is_admin: true
User.create! username: "User", email: "user@gmail.com",
  password: "1", password_confirmation: "1", is_admin: false
Subject.create! name: "MySQL", question_number: 3, duration: 5
Subject.create! name: "Git", question_number: 3, duration: 1
Subject.create! name: "Ruby", question_number: 5, duration: 10
30.times do |n|
  name = Faker::Name.last_name
  question_number = Faker::Number.between(1, 10)
  duration = Faker::Number.between(1, 5)
  Subject.create! name: name,
    question_number: question_number,
    duration: duration
end
