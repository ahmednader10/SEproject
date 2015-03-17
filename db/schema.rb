<<<<<<< HEAD
# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150317003229) do

  create_table "admins", force: true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["forum_id"], name: "index_admins_on_forum_id"
  add_index "admins", ["user_id"], name: "index_admins_on_user_id"

  create_table "comments", force: true do |t|
    t.integer  "idea_id"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "privacy"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "friend_name"
    t.boolean  "accepted"
    t.boolean  "rejected"
    t.string   "requesting"
    t.string   "pending"
  end

  create_table "ideas", force: true do |t|
    t.string   "text"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "memberships", force: true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.boolean  "accept"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["forum_id"], name: "index_memberships_on_forum_id"
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "notifications", force: true do |t|
    t.string   "info"
    t.boolean  "seen"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "username"
    t.string   "gender"
    t.string   "full_name"
    t.string   "password_question"
    t.string   "answer_for_password_question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

end
=======
# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150317003229) do

  create_table "admins", force: true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["forum_id"], name: "index_admins_on_forum_id"
  add_index "admins", ["user_id"], name: "index_admins_on_user_id"

  create_table "comments", force: true do |t|
    t.integer  "idea_id"
    t.integer  "user_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "privacy"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "friend_name"
    t.boolean  "accepted"
    t.boolean  "rejected"
    t.string   "requesting"
    t.string   "pending"
  end

  create_table "ideas", force: true do |t|
    t.string   "text"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "memberships", force: true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.boolean  "accept"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["forum_id"], name: "index_memberships_on_forum_id"
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "notifications", force: true do |t|
    t.string   "info"
    t.boolean  "seen"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "username"
    t.string   "gender"
    t.string   "full_name"
    t.string   "password_question"
    t.string   "answer_for_password_question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

end
>>>>>>> 2a2a7bd6ce768d0cd89cb20e7abbc41e9877a2c5
