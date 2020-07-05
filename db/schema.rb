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

ActiveRecord::Schema.define(version: 2020_07_04_214136) do

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "joke_id"
    t.integer "like_id"
    t.text "content"
    t.datetime "posted"
  end

  create_table "jokes", force: :cascade do |t|
    t.text "content"
    t.string "genre"
    t.integer "like_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.string "location"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comment_id"
    t.integer "joke_id"
    t.integer "like_counter"
  end

  create_table "minions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "minion_counter"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_name"
    t.integer "age"
    t.text "bio"
    t.string "cohort"
    t.datetime "member_since"
    t.string "password"
    t.integer "num_of_minion_followed"
    t.integer "minion_id"
    t.boolean "status"
  end

end
