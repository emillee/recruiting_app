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

ActiveRecord::Schema.define(version: 20140703015348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "articles", force: true do |t|
    t.string   "title",       default: ""
    t.text     "body",        default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "investor_id"
    t.string   "link"
  end

  create_table "chatroom_messages", force: true do |t|
    t.integer "chatroom_id"
    t.integer "message_id"
  end

  add_index "chatroom_messages", ["chatroom_id"], name: "index_chatroom_messages_on_chatroom_id", using: :btree

  create_table "chatroom_users", force: true do |t|
    t.integer  "chatroom_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chatroom_users", ["chatroom_id"], name: "index_chatroom_users_on_chatroom_id", using: :btree
  add_index "chatroom_users", ["user_id"], name: "index_chatroom_users_on_user_id", using: :btree

  create_table "chatrooms", force: true do |t|
    t.integer "admin_id"
    t.string  "room_id"
  end

  create_table "companies", force: true do |t|
    t.string   "name",                    null: false
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
    t.text     "scale_commentary"
    t.string   "team_soundbite"
    t.text     "team_commentary"
    t.text     "wolfpack_commentary"
    t.text     "the_big_idea_commentary"
    t.string   "company_blog_url"
    t.string   "the_big_idea_soundbite"
    t.string   "scale_soundbite"
    t.string   "culture_soundbite"
    t.text     "culture_commentary"
    t.string   "tech_blog_url"
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

  create_table "images", force: true do |t|
    t.string   "image_file_file_name"
    t.string   "image_file_content_type"
    t.integer  "image_file_file_size"
    t.datetime "image_file_updated_at"
    t.integer  "article_id"
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
    t.string   "key_phrases",                  default: [], array: true
    t.string   "req_skills",                   default: [], array: true
    t.text     "technical_problem_commentary"
  end

  add_index "jobs", ["company_id"], name: "index_jobs_on_company_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "message_body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "object_skills", force: true do |t|
    t.integer "user_id"
    t.integer "level"
    t.integer "company_id"
    t.integer "skill_id"
  end

  add_index "object_skills", ["company_id"], name: "index_object_skills_on_company_id", using: :btree
  add_index "object_skills", ["user_id"], name: "index_object_skills_on_user_id", using: :btree

  create_table "prospects", force: true do |t|
    t.string   "github_username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "date_joined"
    t.string   "email"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer "preapproved_user_id"
    t.integer "job_id"
    t.integer "preapproval_applicant_id"
  end

  create_table "user_jobs", force: true do |t|
    t.integer "user_id"
    t.integer "bookmarked_job_id"
    t.integer "applied_via_wolfpack_job_id"
    t.integer "removed_job_id"
    t.integer "viewed_job_id"
  end

  add_index "user_jobs", ["user_id", "applied_via_wolfpack_job_id"], name: "index_user_jobs_on_user_id_and_applied_via_wolfpack_job_id", using: :btree
  add_index "user_jobs", ["user_id", "bookmarked_job_id"], name: "index_user_jobs_on_user_id_and_bookmarked_job_id", using: :btree
  add_index "user_jobs", ["user_id", "removed_job_id"], name: "index_user_jobs_on_user_id_and_removed_job_id", using: :btree
  add_index "user_jobs", ["user_id"], name: "index_user_jobs_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                               null: false
    t.string   "password_digest",                     null: false
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "job_settings"
    t.boolean  "is_admin"
    t.boolean  "is_guest"
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
    t.text     "intro"
    t.string   "link_to_online_profile"
    t.string   "linkedin_url"
    t.string   "github_url"
    t.string   "behance_url"
    t.string   "personal_blog_url"
    t.string   "twitter_username"
    t.string   "stack_overflow"
    t.string   "one_liner"
    t.boolean  "is_applicant"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree

end
