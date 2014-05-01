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

ActiveRecord::Schema.define(version: 20140430225136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "articles", force: true do |t|
    t.string   "title",      default: ""
    t.text     "body",       default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_employees"
    t.string   "total_money_raised"
    t.string   "twitter_username"
    t.string   "category_code"
    t.string   "city"
    t.integer  "twitter_followers"
    t.string   "career_page_link"
    t.integer  "year_founded"
    t.text     "overview"
    t.string   "neighborhood"
    t.string   "snapshots_file_name"
    t.string   "snapshots_content_type"
    t.integer  "snapshots_file_size"
    t.datetime "snapshots_updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "groups", force: true do |t|
    t.string "name"
  end

  create_table "identities", force: true do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "oauth_secret"
  end

  create_table "investors", force: true do |t|
    t.string   "name"
    t.string   "neighborhood"
    t.string   "stage",                  default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.text     "overview"
    t.decimal  "check_size",             default: [], array: true
    t.string   "snapshots_file_name"
    t.string   "snapshots_content_type"
    t.integer  "snapshots_file_size"
    t.datetime "snapshots_updated_at"
    t.text     "about"
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
    t.string   "sub_dept"
    t.text     "description"
    t.string   "key_phrases", default: [], array: true
    t.string   "req_skills",  default: [], array: true
  end

  add_index "jobs", ["company_id"], name: "index_jobs_on_company_id", using: :btree

  create_table "object_skills", force: true do |t|
    t.integer "user_id"
    t.integer "level"
    t.integer "company_id"
    t.integer "skill_id"
  end

  add_index "object_skills", ["company_id"], name: "index_object_skills_on_company_id", using: :btree
  add_index "object_skills", ["user_id"], name: "index_object_skills_on_user_id", using: :btree

  create_table "search_suggestions", force: true do |t|
    t.string   "term"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "popularity"
  end

  create_table "skills", force: true do |t|
    t.string   "skill_name"
    t.string   "skill_dept"
    t.string   "skill_sub_dept"
    t.string   "required_phrases",  default: [], array: true
    t.string   "preferred_phrases", default: [], array: true
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "company_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id"
  end

  create_table "tags", force: true do |t|
    t.string   "tag_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taxonomies", force: true do |t|
    t.string "title"
    t.string "level"
    t.string "base_title"
    t.string "dept"
    t.hstore "expert_phrases"
  end

  create_table "user_articles", force: true do |t|
    t.integer "user_id"
    t.integer "article_id"
  end

  create_table "user_job_preapprovals", force: true do |t|
    t.integer "user_id"
    t.integer "job_id"
  end

  create_table "user_jobs", force: true do |t|
    t.integer "user_id"
    t.integer "saved_job_id"
    t.integer "applied_job_id"
    t.integer "removed_job_id"
  end

  add_index "user_jobs", ["user_id", "applied_job_id"], name: "index_user_jobs_on_user_id_and_applied_job_id", using: :btree
  add_index "user_jobs", ["user_id", "removed_job_id"], name: "index_user_jobs_on_user_id_and_removed_job_id", using: :btree
  add_index "user_jobs", ["user_id", "saved_job_id"], name: "index_user_jobs_on_user_id_and_saved_job_id", using: :btree
  add_index "user_jobs", ["user_id"], name: "index_user_jobs_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                               null: false
    t.string   "password_digest",                     null: false
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "job_settings"
    t.boolean  "is_admin"
    t.boolean  "guest"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "fname"
    t.string   "lname"
    t.string   "title"
    t.string   "location"
    t.integer  "company_id"
    t.hstore   "job_filters",            default: {}
    t.text     "company_settings"
    t.integer  "investor_company_id"
    t.string   "snapshots_file_name"
    t.string   "snapshots_content_type"
    t.integer  "snapshots_file_size"
    t.datetime "snapshots_updated_at"
    t.text     "job_prefs"
    t.string   "location_from"
    t.boolean  "is_member"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree

end
