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

ActiveRecord::Schema.define(version: 20160119032948) do

  create_table "categories", force: :cascade do |t|
    t.string   "category_name", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchandise_relevances", force: :cascade do |t|
    t.integer  "merchandise_id",             null: false
    t.integer  "target_id",                  null: false
    t.integer  "quantity",       default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "merchandises", force: :cascade do |t|
    t.string   "merchandise_name",                 null: false
    t.integer  "price",                            null: false
    t.integer  "stock",                            null: false
    t.integer  "category",                         null: false
    t.integer  "sub_category",                     null: false
    t.integer  "type_status",                      null: false
    t.boolean  "display",          default: true,  null: false
    t.boolean  "recommend",        default: false, null: false
    t.binary   "data"
    t.string   "content_type"
    t.integer  "sales",            default: 0,     null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id",       null: false
    t.integer  "merchandise_id", null: false
    t.integer  "quantity",       null: false
    t.integer  "sub_total",      null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "order_details", ["merchandise_id"], name: "index_order_details_on_merchandise_id"
  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.string   "user_address",                null: false
    t.integer  "total",                       null: false
    t.integer  "delivery_status", default: 1, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.integer  "merchandise_id", null: false
    t.integer  "user_id",        null: false
    t.integer  "score",          null: false
    t.string   "title",          null: false
    t.string   "content",        null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "shopping_cart_details", force: :cascade do |t|
    t.integer  "shopping_cart_id", null: false
    t.integer  "merchandise_id",   null: false
    t.integer  "quantity",         null: false
    t.integer  "sub_total",        null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "shopping_cart_details", ["merchandise_id"], name: "index_shopping_cart_details_on_merchandise_id"
  add_index "shopping_cart_details", ["shopping_cart_id"], name: "index_shopping_cart_details_on_shopping_cart_id"

  create_table "shopping_carts", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "total",      default: 0, null: false
    t.string   "address"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "shopping_carts", ["user_id"], name: "index_shopping_carts_on_user_id"

  create_table "sub_categories", force: :cascade do |t|
    t.string   "sub_category_name", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "type_name",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_ranks", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "lower_bound", null: false
    t.integer  "upper_bound", null: false
    t.integer  "discount",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name",                null: false
    t.string   "user_address",             null: false
    t.string   "user_lo",                  null: false
    t.string   "user_ps",                  null: false
    t.string   "user_email"
    t.integer  "user_status",  default: 1, null: false
    t.integer  "total",        default: 0, null: false
    t.integer  "user_rank_id", default: 1, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
