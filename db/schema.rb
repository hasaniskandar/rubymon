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

ActiveRecord::Schema.define(version: 20160115092852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "monsters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.string   "name"
    t.string   "power"
    t.string   "element"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "monsters", ["team_id"], name: "index_monsters_on_team_id", using: :btree
  add_index "monsters", ["user_id"], name: "index_monsters_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams", ["user_id"], name: "index_teams_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "authentication_token"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "monsters", "teams"
  add_foreign_key "monsters", "users"
  add_foreign_key "teams", "users"
end
