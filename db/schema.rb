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

ActiveRecord::Schema.define(version: 20150316185019) do

  create_table "ads", force: true do |t|
    t.string   "picture_url"
    t.string   "destination_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "date"
    t.integer  "tablet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "accuracy"
    t.float    "speed"
    t.float    "altitude"
    t.boolean  "is_gps_provider"
  end

  add_index "locations", ["tablet_id"], name: "index_locations_on_tablet_id"

  create_table "tablets", force: true do |t|
    t.string   "uuid"
    t.string   "flash_token"
    t.string   "salt"
    t.datetime "flash_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tablets", ["user_id"], name: "index_tablets_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
