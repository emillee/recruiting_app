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

ActiveRecord::Schema.define(version: 20140205074242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "name",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_employees"
    t.string   "total_money_raised"
    t.string   "twitter_username"
    t.string   "category_code"
    t.string   "city"
    t.integer  "twitter_followers"
  end

  create_table "jobs", force: true do |t|
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "full_text"
    t.boolean  "is_draft"
    t.integer  "company_id"
    t.string   "dept"
    t.integer  "years_exp"
    t.string   "key_skill_one"
    t.string   "key_skill_two"
    t.string   "sub_dept"
    t.text     "description"
  end

  create_table "taxonomies", force: true do |t|
    t.string "title"
    t.string "level"
    t.string "base_title"
    t.string "dept"
  end

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "job_settings"
    t.boolean  "is_admin"
  end

end
