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

ActiveRecord::Schema.define(version: 20140328234841) do

  create_table "avenues", force: true do |t|
    t.string   "avenue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blocks", force: true do |t|
    t.string   "block"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "busstops", force: true do |t|
    t.string   "name"
    t.string   "lat"
    t.string   "lng"
    t.integer  "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goings", force: true do |t|
    t.string   "start_location"
    t.string   "end_location"
    t.string   "waypoints"
    t.string   "blocks_passed"
    t.integer  "downvotes"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "days_of_week"
    t.integer  "frequency"
    t.string   "schedule"
    t.string   "surroundings"
  end

  add_index "goings", ["line_id"], name: "index_goings_on_line_id", using: :btree

  create_table "lines", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "returns", force: true do |t|
    t.string   "start_location"
    t.string   "end_location"
    t.string   "waypoints"
    t.string   "blocks_passed"
    t.integer  "downvotes"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "days_of_week"
    t.integer  "frequency"
    t.string   "schedule"
    t.string   "surroundings"
  end

  add_index "returns", ["line_id"], name: "index_returns_on_line_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "name"
    t.string   "username"
    t.integer  "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
