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

ActiveRecord::Schema.define(version: 20170421004654) do

  create_table "check_ins", force: :cascade do |t|
    t.string   "name"
    t.datetime "time"
    t.integer  "seconds_since_midnight"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "buddy"
  end

  create_table "micro_fab_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "selections", force: :cascade do |t|
    t.datetime "from_time"
    t.datetime "to_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "time_punches", force: :cascade do |t|
    t.string   "name"
    t.datetime "check_in"
    t.datetime "check_out"
    t.integer  "check_in_seconds"
    t.integer  "check_out_seconds"
    t.integer  "seconds_elapsed"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "buddy"
    t.string   "guest_name"
    t.string   "other_name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",              default: false
    t.string   "activation_digest"
    t.boolean  "activated",          default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "temporary_password"
    t.boolean  "microfab"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
