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

ActiveRecord::Schema.define(version: 20140621181530) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "memberships", force: true do |t|
    t.string "name"
  end

  create_table "memberships_users", force: true do |t|
    t.integer "membership_id"
    t.integer "user_id"
  end

  create_table "specialities", force: true do |t|
    t.string "name"
  end

  create_table "specialities_users", force: true do |t|
    t.integer "speciality_id"
    t.integer "user_id"
  end

  create_table "user_sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                            null: false
    t.string   "crypted_password",                                 null: false
    t.string   "password_salt",                                    null: false
    t.string   "persistence_token",                                null: false
    t.string   "perishable_token",                                 null: false
    t.integer  "login_count",                          default: 0, null: false
    t.integer  "failed_login_count",                   default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",               limit: 128,             null: false
    t.string   "last_name",                limit: 128,             null: false
    t.string   "bio"
    t.string   "linkedin_handle"
    t.string   "twitter_handle"
    t.integer  "registration_step_number"
    t.string   "licensed_in"
  end

end
