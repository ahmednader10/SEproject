# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: 'dovahkiin@gmail.com', password: '12345678', password_confirmation: '12345678', username: 'Dovahkiin', gender: 'male', full_name: 'Dovahkiin Dovah Dov', password_question: 'what?', answer_for_password_question: 'yes')
Notification.create(info: 'NEW NOTIFICATION BITCH', seen: false, user_id: 1)