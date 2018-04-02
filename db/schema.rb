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

ActiveRecord::Schema.define(version: 20180401183251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "title"
    t.bigint "question_id"
    t.boolean "is_correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "user_selections", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "user_id"
    t.bigint "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "correct_answer", default: false
    t.index ["answer_id"], name: "index_user_selections_on_answer_id"
    t.index ["question_id"], name: "index_user_selections_on_question_id"
    t.index ["user_id"], name: "index_user_selections_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.integer "score", default: 0
    t.string "activation_digest"
    t.datetime "activated_at"
    t.boolean "active", default: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "questions", "users"
  add_foreign_key "user_selections", "answers"
  add_foreign_key "user_selections", "questions"
  add_foreign_key "user_selections", "users"
end
