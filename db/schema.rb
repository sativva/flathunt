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

ActiveRecord::Schema.define(version: 20161201141911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string   "name"
    t.string   "mail"
    t.string   "address"
    t.integer  "postal"
    t.string   "phone"
    t.string   "url"
    t.string   "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "announces", force: :cascade do |t|
    t.integer  "price"
    t.string   "address"
    t.string   "floor"
    t.integer  "charge_by_month"
    t.integer  "lot"
    t.string   "agency"
    t.string   "date_of_publication"
    t.boolean  "lift"
    t.integer  "surface"
    t.string   "room"
    t.string   "bedroom"
    t.boolean  "to_renovate"
    t.text     "comment"
    t.boolean  "guard"
    t.text     "option"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "link"
    t.json     "photos"
    t.integer  "search_id"
    t.string   "status"
    t.boolean  "scd_visit"
    t.index ["search_id"], name: "index_announces_on_search_id", using: :btree
  end

  create_table "searches", force: :cascade do |t|
    t.string   "price"
    t.string   "location"
    t.string   "floor"
    t.boolean  "lift"
    t.string   "surface"
    t.string   "room"
    t.string   "bedroom"
    t.string   "to_renovate"
    t.text     "comment"
    t.text     "option"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "userid"
    t.string   "username"
    t.string   "email"
    t.text     "text_for_agency"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_searches_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.string   "user_name"
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.integer  "search_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["search_id"], name: "index_users_on_search_id", using: :btree
  end

  add_foreign_key "announces", "searches"
  add_foreign_key "searches", "users"
  add_foreign_key "users", "searches"
end
