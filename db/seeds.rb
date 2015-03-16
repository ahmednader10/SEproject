# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# IF YOU DO NOT REMOVE THE SEED CREATIONS/DELETIONS/... THEY WILL BE EXECUTED EVERY TIME YOU INVOKE RAKE DB:SEED
User.create(email: 'dovahkiin@gmail.com', password: '12345678', password_confirmation: '12345678', username: 'Dovahkiin', gender: 'male', full_name: 'Dovahkiin Dovah Dov', password_question: 'what?', answer_for_password_question: 'yes')
Notification.create(info: 'NEW NOTIFICATION BITCH', seen: false, user_id: 1)
Forum.create(title: 'araf', description:'araf aktar', privacy: '1')
Idea.create(text: 'araf begad', forum_id: 1, user_id: 1)