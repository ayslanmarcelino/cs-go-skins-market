# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_05_123110) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "city"
    t.string "complement"
    t.string "country"
    t.string "neighborhood"
    t.integer "number"
    t.string "state"
    t.string "street"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "email"
    t.string "document_number"
    t.boolean "active", default: true
    t.string "name"
    t.string "trade_name"
    t.date "opening_date"
    t.string "representative_name"
    t.string "representative_document_number"
    t.string "cell_number"
    t.string "telephone_number"
    t.string "identity_document_type"
    t.string "identity_document_number"
    t.string "identity_document_issuing_agency"
    t.date "birth_date"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id"
    t.index ["address_id"], name: "index_enterprises_on_address_id"
    t.index ["created_by_id"], name: "index_enterprises_on_created_by_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "trade_name"
    t.string "nickname"
    t.string "document_number"
    t.string "cell_number"
    t.string "telephone_number"
    t.string "identity_document_type"
    t.string "identity_document_number"
    t.string "identity_document_issuing_agency"
    t.string "cnh_issuing_state"
    t.string "cnh_number"
    t.string "cnh_record"
    t.string "cnh_type"
    t.date "cnh_expires_at"
    t.string "marital_status_cd"
    t.string "kind_cd"
    t.date "birth_date"
    t.string "owner_type"
    t.bigint "owner_id"
    t.bigint "address_id"
    t.bigint "enterprise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_people_on_address_id"
    t.index ["enterprise_id"], name: "index_people_on_enterprise_id"
    t.index ["owner_type", "owner_id"], name: "index_people_on_owner"
  end

  create_table "skin_logs", force: :cascade do |t|
    t.float "steam_price"
    t.bigint "skin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skin_id"], name: "index_skin_logs_on_skin_id"
  end

  create_table "skins", force: :cascade do |t|
    t.bigint "steam_id"
    t.string "name"
    t.string "market_name"
    t.string "name_color"
    t.string "exterior"
    t.string "image"
    t.string "inspect_url"
    t.string "name_tag"
    t.string "kind"
    t.string "gun_kind"
    t.float "float"
    t.float "steam_price", default: 0.0
    t.float "first_steam_price", default: 0.0
    t.float "csmoney_price", default: 0.0
    t.float "amount_paid", default: 0.0
    t.float "sale_value", default: 0.0
    t.boolean "stattrak", default: false
    t.boolean "has_sticker", default: false
    t.boolean "available", default: true
    t.boolean "has_name_tag", default: false
    t.string "sticker_name", default: "{}"
    t.string "sticker_image", default: [], array: true
    t.datetime "expiration_date"
    t.bigint "steam_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "transaction_id"
    t.index ["steam_account_id"], name: "index_skins_on_steam_account_id"
    t.index ["transaction_id"], name: "index_skins_on_transaction_id"
  end

  create_table "steam_accounts", force: :cascade do |t|
    t.string "steam_id"
    t.string "steam_custom_id"
    t.string "profile_url"
    t.string "nickname"
    t.string "avatar_url"
    t.string "avatar_medium_url"
    t.string "avatar_full_url"
    t.string "real_name"
    t.boolean "active", default: true
    t.bigint "owner_id"
    t.bigint "enterprise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enterprise_id"], name: "index_steam_accounts_on_enterprise_id"
    t.index ["owner_id"], name: "index_steam_accounts_on_owner_id"
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string "description"
    t.integer "counter", default: 0
    t.bigint "enterprise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enterprise_id"], name: "index_transaction_types_on_enterprise_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.float "value"
    t.string "aasm_state"
    t.bigint "owner_id"
    t.bigint "transaction_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_transactions_on_owner_id"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "enterprise_id"
    t.string "kind_cd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id"
    t.index ["created_by_id"], name: "index_user_roles_on_created_by_id"
    t.index ["enterprise_id"], name: "index_user_roles_on_enterprise_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.bigint "person_id"
    t.bigint "current_enterprise_id"
    t.bigint "created_by_id"
    t.index ["created_by_id"], name: "index_users_on_created_by_id"
    t.index ["current_enterprise_id"], name: "index_users_on_current_enterprise_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["person_id"], name: "index_users_on_person_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "enterprises", "addresses"
  add_foreign_key "enterprises", "users", column: "created_by_id"
  add_foreign_key "people", "addresses"
  add_foreign_key "people", "enterprises"
  add_foreign_key "skin_logs", "skins"
  add_foreign_key "skins", "steam_accounts"
  add_foreign_key "skins", "transactions"
  add_foreign_key "steam_accounts", "enterprises"
  add_foreign_key "steam_accounts", "users", column: "owner_id"
  add_foreign_key "transaction_types", "enterprises"
  add_foreign_key "transactions", "transaction_types"
  add_foreign_key "transactions", "users", column: "owner_id"
  add_foreign_key "user_roles", "enterprises"
  add_foreign_key "user_roles", "users"
  add_foreign_key "user_roles", "users", column: "created_by_id"
  add_foreign_key "users", "enterprises", column: "current_enterprise_id"
  add_foreign_key "users", "people"
  add_foreign_key "users", "users", column: "created_by_id"
end
