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

ActiveRecord::Schema.define(version: 20150506042515) do

  create_table "actions", force: true do |t|
    t.string   "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",     default: false
    t.string   "user_email"
  end

  create_table "admins", force: true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["forum_id"], name: "index_admins_on_forum_id"
  add_index "admins", ["user_id"], name: "index_admins_on_user_id"

  create_table "blockers", force: true do |t|
    t.integer  "blocker_id"
    t.integer  "blocked_id"
    t.string   "blocker"
    t.string   "blocked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blocks", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "category"
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
    t.string   "requester"
    t.string   "requested"
    t.string   "requests"
  end

  create_table "ideas", force: true do |t|
    t.string   "text"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "likeideas", force: true do |t|
    t.integer  "user_id"
    t.integer  "idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "report_users", force: true do |t|
    t.integer  "reporter_id"
    t.integer  "reported_id"
    t.string   "reporter"
    t.string   "reported"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reportcomments", force: true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reportideas", force: true do |t|
    t.integer  "user_id"
    t.integer  "idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sysadmins", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "privacy",                      default: 1
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

end
