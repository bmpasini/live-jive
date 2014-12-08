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

ActiveRecord::Schema.define(version: 20141204184347) do

  create_table "band_plays_genres", force: true do |t|
    t.integer  "band_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "band_plays_genres", ["band_id", "genre_id"], name: "index_band_plays_genres_on_band_id_and_genre_id", unique: true, using: :btree

  create_table "bands", force: true do |t|
    t.string   "bandname"
    t.string   "name"
    t.text     "bio"
    t.string   "website"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.string   "reset_digest"
    t.boolean  "identity_confirmed?", default: false
    t.datetime "activated_at"
    t.datetime "reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "concert_goings", force: true do |t|
    t.string   "review"
    t.integer  "rating"
    t.integer  "goer_id"
    t.integer  "concert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concert_goings", ["goer_id", "concert_id"], name: "index_concert_goings_on_goer_id_and_concert_id", unique: true, using: :btree

  create_table "concert_lists", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "list_owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concert_lists", ["list_owner_id", "created_at"], name: "index_concert_lists_on_list_owner_id_and_created_at", using: :btree

  create_table "concerts", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "buy_tickets_website"
    t.datetime "cdatetime"
    t.string   "location_name"
    t.string   "ccity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fanships", force: true do |t|
    t.integer  "band_id"
    t.integer  "fan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fanships", ["band_id", "fan_id"], name: "index_fanships_on_band_id_and_fan_id", unique: true, using: :btree

  create_table "genres", force: true do |t|
    t.string   "genre"
    t.string   "subgenre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lineups", force: true do |t|
    t.integer  "band_id"
    t.integer  "concert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lineups", ["band_id", "concert_id"], name: "index_lineups_on_band_id_and_concert_id", unique: true, using: :btree

  create_table "recommendations", force: true do |t|
    t.integer  "concert_id"
    t.integer  "concert_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommendations", ["concert_list_id", "concert_id"], name: "index_recommendations_on_concert_list_id_and_concert_id", unique: true, using: :btree

  create_table "tickets", force: true do |t|
    t.string   "tier"
    t.integer  "price"
    t.integer  "how_many_left"
    t.integer  "concert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_likes_genres", force: true do |t|
    t.integer  "user_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_likes_genres", ["user_id", "genre_id"], name: "index_user_likes_genres_on_user_id_and_genre_id", unique: true, using: :btree

  create_table "user_relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_relationships", ["followed_id"], name: "index_user_relationships_on_followed_id", using: :btree
  add_index "user_relationships", ["follower_id", "followed_id"], name: "index_user_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "user_relationships", ["follower_id"], name: "index_user_relationships_on_follower_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "name"
    t.integer  "year_of_birth"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.string   "city_of_birth"
    t.integer  "reputation_score",     default: 0
    t.boolean  "is_admin?",            default: false
    t.datetime "reset_sent_at"
    t.datetime "penultimate_login_at", default: '2014-12-08 07:24:23'
    t.datetime "last_login_at",        default: '2014-12-08 07:24:23'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
