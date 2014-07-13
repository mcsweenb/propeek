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

ActiveRecord::Schema.define(version: 20140713135551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "educations", force: true do |t|
    t.string   "qualification"
    t.string   "institution"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", force: true do |t|
    t.string   "company_name"
    t.string   "company_website"
    t.string   "title"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages_users", force: true do |t|
    t.integer  "language_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.string "name"
  end

  create_table "memberships_users", force: true do |t|
    t.integer "membership_id"
    t.integer "user_id"
  end

  create_table "professions", force: true do |t|
    t.string "name", limit: 64
  end

  create_table "reviews", force: true do |t|
    t.integer  "review_for_id"
    t.integer  "review_by_id"
    t.string   "review"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["created_at"], :name => "index_reviews_on_created_at"
  add_index "reviews", ["review_by_id"], :name => "index_reviews_on_review_by_id"
  add_index "reviews", ["review_for_id"], :name => "index_reviews_on_review_for_id"

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
    t.string   "email",                                                                                             null: false
    t.string   "crypted_password",                                                                                  null: false
    t.string   "password_salt",                                                                                     null: false
    t.string   "persistence_token",                                                                                 null: false
    t.string   "perishable_token",                                                                                  null: false
    t.integer  "login_count",                                                                       default: 0,     null: false
    t.integer  "failed_login_count",                                                                default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",               limit: 128,                                                              null: false
    t.string   "last_name",                limit: 128,                                                              null: false
    t.string   "bio"
    t.string   "linkedin_handle"
    t.string   "twitter_handle"
    t.integer  "registration_step_number"
    t.string   "licensed_in"
    t.string   "company_name"
    t.string   "company_website"
    t.string   "job_title"
    t.string   "phone_1"
    t.string   "phone_2"
    t.string   "phone_3"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "min_hourly_cents"
    t.string   "min_hourly_currency",                                                               default: "USD", null: false
    t.integer  "max_hourly_cents"
    t.string   "max_hourly_currency",                                                               default: "USD", null: false
    t.integer  "min_daily_cents"
    t.string   "min_daily_currency",                                                                default: "USD", null: false
    t.integer  "max_daily_cents"
    t.string   "max_daily_currency",                                                                default: "USD", null: false
    t.string   "fee_notes"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.spatial  "lonlat",                   limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.string   "profession_name",          limit: 64
  end

  add_index "users", ["lonlat"], :name => "index_users_on_lonlat", :spatial => true

end
