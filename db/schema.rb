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

ActiveRecord::Schema.define(version: 20151015221920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "imgur_id",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "image_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "imgur_id",   limit: 255
    t.string   "link",       limit: 255
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "missions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "trip_id"
    t.integer "album_id"
  end

  add_index "missions", ["trip_id", "user_id"], name: "index_missions_on_trip_id_and_user_id", using: :btree
  add_index "missions", ["user_id", "trip_id"], name: "index_missions_on_user_id_and_trip_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "country",     limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "uid"
  end

  create_table "users", force: :cascade do |t|
    t.integer  "album_id"
    t.integer  "image_id"
    t.string   "password_digest", limit: 255
    t.string   "name",            limit: 255
    t.string   "username",        limit: 255
    t.string   "email",           limit: 255
    t.string   "bio",             limit: 255
    t.string   "token",           limit: 255
    t.string   "admin",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
