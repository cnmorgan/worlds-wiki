# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_17_053558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_privileges", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "world_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_admin_privileges_on_user_id"
    t.index ["world_id"], name: "index_admin_privileges_on_world_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "sub_wiki_id", null: false
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_categories_on_category_id"
    t.index ["sub_wiki_id"], name: "index_categories_on_sub_wiki_id"
  end

  create_table "edits", force: :cascade do |t|
    t.text "summary"
    t.bigint "user_id", null: false
    t.bigint "page_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "content"
    t.index ["page_id"], name: "index_edits_on_page_id"
    t.index ["user_id"], name: "index_edits_on_user_id"
  end

  create_table "page_categories", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_page_categories_on_category_id"
    t.index ["page_id"], name: "index_page_categories_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.text "content"
    t.bigint "sub_wiki_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "view_count", default: 0
    t.index ["sub_wiki_id"], name: "index_pages_on_sub_wiki_id"
  end

  create_table "sub_wikis", force: :cascade do |t|
    t.bigint "world_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["world_id"], name: "index_sub_wikis_on_world_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_site_admin", default: false
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "worlds", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_worlds_on_name", unique: true
    t.index ["user_id"], name: "index_worlds_on_user_id"
  end

  add_foreign_key "admin_privileges", "worlds"
  add_foreign_key "categories", "sub_wikis"
  add_foreign_key "edits", "pages"
  add_foreign_key "edits", "users"
  add_foreign_key "page_categories", "categories"
  add_foreign_key "page_categories", "pages"
  add_foreign_key "sub_wikis", "worlds"
  add_foreign_key "worlds", "users"
end
