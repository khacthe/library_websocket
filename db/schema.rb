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

ActiveRecord::Schema.define(version: 20170412064831) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "authorimage"
  end

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "number_book"
    t.integer  "pages_number"
    t.integer  "author_id"
    t.integer  "category_id"
    t.integer  "publisher_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "image"
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "borrow_books", force: :cascade do |t|
    t.datetime "date_from"
    t.datetime "date_to"
    t.boolean  "status"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrow_books_on_book_id"
    t.index ["user_id"], name: "index_borrow_books_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "commments", force: :cascade do |t|
    t.text     "description"
    t.float    "rate"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["book_id"], name: "index_commments_on_book_id"
    t.index ["user_id"], name: "index_commments_on_user_id"
  end

  create_table "follow_authors", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_follow_authors_on_author_id"
    t.index ["user_id"], name: "index_follow_authors_on_user_id"
  end

  create_table "follow_books", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_follow_books_on_book_id"
    t.index ["user_id"], name: "index_follow_books_on_user_id"
  end

  create_table "follow_users", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "like_actives", force: :cascade do |t|
    t.boolean  "is_like"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_like_actives_on_book_id"
    t.index ["user_id"], name: "index_like_actives_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "notification_type"
    t.string   "notification"
    t.string   "notification_link"
    t.boolean  "read",              default: false
    t.boolean  "checked",           default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fullname"
    t.string   "password_digest"
    t.string   "email"
    t.string   "address"
    t.string   "phone"
    t.string   "avatar"
    t.boolean  "is_admin",          default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.datetime "reset_sent_at"
    t.string   "reset_digest"
  end

end
