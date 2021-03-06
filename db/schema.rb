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

ActiveRecord::Schema.define(version: 20140228145519) do

  create_table "courses", force: true do |t|
    t.string   "title"
    t.string   "subject"
    t.integer  "hours"
    t.text     "description"
    t.decimal  "price"
    t.integer  "tutor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", force: true do |t|
    t.integer  "user_id"
    t.integer  "learning_course_id"
    t.boolean  "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["learning_course_id"], name: "index_enrollments_on_learning_course_id"
  add_index "enrollments", ["user_id", "learning_course_id"], name: "index_enrollments_on_user_id_and_learning_course_id", unique: true
  add_index "enrollments", ["user_id"], name: "index_enrollments_on_user_id"

  create_table "transfers", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.decimal  "amount"
    t.string   "message",      limit: 128
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transfers", ["recipient_id"], name: "index_transfers_on_recipient_id"
  add_index "transfers", ["sender_id"], name: "index_transfers_on_sender_id"

  create_table "users", force: true do |t|
    t.string   "surname",         limit: 64
    t.string   "name",            limit: 64
    t.string   "patronymic",      limit: 64
    t.boolean  "sex"
    t.string   "email"
    t.string   "phone",           limit: 32
    t.decimal  "wallet"
    t.boolean  "tutor"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
