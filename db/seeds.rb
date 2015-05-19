# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(title: "Sports")
Category.create(title: "Politics")
Category.create(title: "Gaming")
Category.create(title: "Music")
Category.create(title: "Movies")
Category.create(title: "Academics")

#Ideas.create(title: "i1", text: "i1 text1", forum_id: 1, user_id: 1 )
#Ideas.create(title: "i1", text: "i1 text1", forum_id: 1, user_id: 8 )
