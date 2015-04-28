class CreateDatabase < ActiveRecord::Migration
  def self.up
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

ActiveRecord::Schema.define(version: 20150424010441) do

  create_table "allusers", primary_key: "user_id", force: :cascade do |t|
    t.string  "type",            limit: 20
    t.string  "name",            limit: 20
    t.integer "review_count",    limit: 4
    t.text    "friends",         limit: 16777215
    t.float   "average_stars",   limit: 24
    t.string  "password_digest", limit: 255
  end

  create_table "business_category", id: false, force: :cascade do |t|
    t.string "business_id", limit: 30, null: false
    t.string "category",    limit: 45, null: false
  end

  create_table "businesses", primary_key: "business_id", force: :cascade do |t|
    t.text    "name",         limit: 65535
    t.text    "full_address", limit: 65535
    t.string  "city",         limit: 45
    t.string  "state",        limit: 45
    t.float   "latitude",     limit: 24
    t.float   "longitude",    limit: 24
    t.float   "star",         limit: 24
    t.text    "hours",        limit: 65535
    t.integer "reviewNum",    limit: 4
  end

  create_table "food_classes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "food_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "isfriends", id: false, force: :cascade do |t|
    t.string "user_id",   limit: 45, null: false
    t.string "friend_id", limit: 45, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "restaurant_id", limit: 255
    t.string   "city",          limit: 255
    t.string   "state",         limit: 255
    t.string   "full_address",  limit: 255
    t.string   "hours",         limit: 255
    t.float    "distance",      limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "restaurant_category", id: false, force: :cascade do |t|
    t.integer "restaurant_id", limit: 4,  default: 0, null: false
    t.string  "category",      limit: 45,             null: false
  end

  create_table "restaurants", id: false, force: :cascade do |t|
    t.integer "restaurant_id", limit: 4,     default: 0, null: false
    t.text    "name",          limit: 65535
    t.text    "full_address",  limit: 65535
    t.string  "city",          limit: 45
    t.string  "state",         limit: 45
    t.float   "latitude",      limit: 24
    t.float   "longitude",     limit: 24
    t.float   "star",          limit: 24
    t.text    "hours",         limit: 65535
    t.integer "reviewNum",     limit: 4
  end

  create_table "reviews", id: false, force: :cascade do |t|
    t.text  "type",        limit: 65535
    t.text  "business_id", limit: 65535
    t.text  "user_id",     limit: 65535
    t.float "stars",       limit: 24
    t.text  "text",        limit: 65535
    t.date  "date"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end

  end
 
  def self.down
    # drop all the tables if you really need
    # to support migration back to version 0
  end
end