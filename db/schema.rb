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

ActiveRecord::Schema.define(version: 20200826142551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.float "unit_price"
    t.integer "max_unit_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_features_on_code"
    t.index ["name"], name: "index_features_on_name"
  end

  create_table "features_plans", id: false, force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "feature_id", null: false
    t.index ["plan_id", "feature_id"], name: "index_features_plans_on_plan_id_and_feature_id", unique: true
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_plans_on_name"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "plan_id"
    t.datetime "subscription_date", null: false
    t.integer "billing_day", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id", "plan_id"], name: "index_subscriptions_on_user_id_and_plan_id", unique: true
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "subscription_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_transactions_on_subscription_id"
    t.index ["user_id", "subscription_id"], name: "index_transactions_on_user_id_and_subscription_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "usages", force: :cascade do |t|
    t.bigint "subscription_id"
    t.integer "feature_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_usages_on_subscription_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "profile_photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
