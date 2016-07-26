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

ActiveRecord::Schema.define(version: 20160724135436) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "answers", force: :cascade do |t|
    t.string   "answer"
    t.boolean  "is_correct"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "exams", force: :cascade do |t|
    t.integer  "status",     default: 0
    t.datetime "started_at"
    t.integer  "spent_time", default: 0
    t.integer  "score",      default: 0
    t.integer  "user_id"
    t.integer  "subject_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "exams", ["subject_id"], name: "index_exams_on_subject_id"
  add_index "exams", ["user_id"], name: "index_exams_on_user_id"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "other_answers", force: :cascade do |t|
    t.string   "answer"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "other_answers", ["question_id"], name: "index_other_answers_on_question_id"

  create_table "questions", force: :cascade do |t|
    t.string   "question"
    t.integer  "question_type"
    t.integer  "subject_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "questions", ["subject_id"], name: "index_questions_on_subject_id"

  create_table "results", force: :cascade do |t|
    t.boolean  "state",            default: false
    t.string   "multiple_answers"
    t.integer  "exam_id"
    t.integer  "question_id"
    t.integer  "other_answer_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "results", ["exam_id"], name: "index_results_on_exam_id"
  add_index "results", ["other_answer_id"], name: "index_results_on_other_answer_id"
  add_index "results", ["question_id"], name: "index_results_on_question_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "question_number"
    t.integer  "duration"
    t.string   "slug"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "subjects", ["slug"], name: "index_subjects_on_slug", unique: true

  create_table "suggest_answers", force: :cascade do |t|
    t.string   "answer"
    t.boolean  "is_correct"
    t.integer  "suggest_question_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "suggest_answers", ["suggest_question_id"], name: "index_suggest_answers_on_suggest_question_id"

  create_table "suggest_questions", force: :cascade do |t|
    t.string   "question"
    t.integer  "question_type"
    t.integer  "approve",       default: 0
    t.integer  "user_id"
    t.integer  "subject_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "suggest_questions", ["subject_id"], name: "index_suggest_questions_on_subject_id"
  add_index "suggest_questions", ["user_id"], name: "index_suggest_questions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.boolean  "is_admin",               default: false
    t.string   "provider"
    t.string   "uid"
    t.string   "slug"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

end
