# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# IF YOU DO NOT REMOVE THE SEED CREATIONS/DELETIONS/... THEY WILL BE EXECUTED EVERY TIME YOU INVOKE RAKE DB:SEED

Idea.create(title: 'testIdea', text: 'das text', user_id: 1, forum_id: 1)