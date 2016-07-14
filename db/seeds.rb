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
