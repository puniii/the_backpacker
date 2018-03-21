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

ActiveRecord::Schema.define(version: 20180306132927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "post_id"
    t.text "content"
    t.text "image"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.text "image"
    t.text "spot"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "toilets", force: :cascade do |t|
    t.text "information"
    t.text "comfortable"
    t.text "box_number"
    t.text "baggage"
    t.integer "post_id"
  end

  create_table "troubles", force: :cascade do |t|
    t.text "atm"
    t.text "station"
    t.text "bus"
    t.text "pharmacy"
    t.integer "post_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.text "image"
    t.text "area"
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wifis", force: :cascade do |t|
    t.text "condition_1"
    t.text "condition_2"
    t.text "condition_3"
    t.integer "post_id"
  end

  add_foreign_key "comments", "posts"
end
