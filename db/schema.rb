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

ActiveRecord::Schema.define(version: 20170222032500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "imgur_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "image_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "imgur_id"
    t.string   "link"
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "missions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "trip_id"
    t.integer "album_id"
    t.index ["trip_id", "user_id"], name: "index_missions_on_trip_id_and_user_id", using: :btree
    t.index ["user_id", "trip_id"], name: "index_missions_on_user_id_and_trip_id", using: :btree
  end

  create_table "resources", force: :cascade do |t|
    t.integer  "trip_id"
    t.string   "text"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_tokens_on_uid", using: :btree
    t.index ["user_id"], name: "index_tokens_on_user_id", using: :btree
  end

  create_table "trips", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "country"
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
    t.string   "password_digest"
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "bio"
    t.string   "token"
    t.string   "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "images_count",    default: 0, null: false
  end

end
