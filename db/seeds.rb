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

Subject.create! name: "MySQL", question_number: 5, duration: 60
Subject.create! name: "Git", question_number: 7, duration: 60
Subject.create! name: "Ruby", question_number: 5, duration: 60

10.times do
  Exam.create! status: 0, user_id: 2, subject_id: 1
end

subjects = Subject.all
subjects.each do |subject|
  5.times do
    subject.questions.build(
      question: Faker::Lorem.sentence,
      question_type: 0).save
  end
  5.times do
    subject.questions.build(
      question: Faker::Lorem.sentence,
      question_type: 1).save
  end
end

questions = Question.all
questions.each do |question|
  question.answers.build(answer: Faker::Lorem.characters(5),
      is_correct: true).save
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: false).save
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: false).save
  question.answers.build(answer: Faker::Lorem.characters(5),
    is_correct: false).save
end
