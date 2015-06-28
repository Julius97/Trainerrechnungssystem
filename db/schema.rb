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

ActiveRecord::Schema.define(version: 20150628082416) do

  create_table "customers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groupclassifications", force: true do |t|
    t.integer  "group_id"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.integer  "trainer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "for_free"
    t.string   "color_code"
  end

  create_table "logins", force: true do |t|
    t.integer  "user_id"
    t.boolean  "mobile_device"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prices", force: true do |t|
    t.integer  "price_per_lesson"
    t.integer  "discount_per_lesson"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainers", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainings", force: true do |t|
    t.integer  "groupclassification_id"
    t.datetime "training_start"
    t.datetime "training_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "participated"
  end

  create_table "trainingsplans", force: true do |t|
    t.integer  "group_id"
    t.integer  "wday"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin_permissions"
    t.string   "mail_address"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "last_seen_at"
  end

end
