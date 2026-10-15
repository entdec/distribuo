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

ActiveRecord::Schema[8.1].define(version: 2026_10_15_142000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"
  enable_extension "uuid-ossp"

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    t.index ["record_type", "record_id"], name: "index_active_storage_attachments_on_record"
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
    t.index ["blob_id"], name: "index_active_storage_variant_records_on_blob_id"
  end

  create_table "distribuo_apps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "release_type"
    t.string "operating_system"
    t.string "mobiliable_type"
    t.uuid "mobiliable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mobiliable_type", "mobiliable_id"], name: "index_app_on_mobiliable"
  end

  create_table "distribuo_downloads", force: :cascade do |t|
    t.uuid "distribuo_release_id", null: false
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["distribuo_release_id"], name: "index_distribuo_downloads_on_distribuo_release_id"
  end

  create_table "distribuo_releases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "app_id"
    t.integer "position"
    t.string "version"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "build_number"
    t.string "bundle_id"
    t.index ["app_id"], name: "index_distribuo_releases_on_app_id"
  end

  create_table "mensa_exports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "table_name", null: false
    t.uuid "table_view_id"
    t.string "scope"
    t.string "format"
    t.string "status", default: "pending", null: false
    t.jsonb "config", default: {}, null: false
    t.string "filename"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "repeat", default: "", null: false
    t.datetime "last_repeat_run_at"
    t.string "password"
    t.index ["last_repeat_run_at"], name: "index_mensa_exports_on_last_repeat_run_at"
    t.index ["repeat"], name: "index_mensa_exports_on_repeat"
    t.index ["status"], name: "index_mensa_exports_on_status"
    t.index ["table_name"], name: "index_mensa_exports_on_table_name"
    t.index ["table_view_id"], name: "index_mensa_exports_on_table_view_id"
    t.index ["user_id"], name: "index_mensa_exports_on_user_id"
  end

  create_table "mensa_table_views", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "table_name"
    t.string "name"
    t.jsonb "config"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["config"], name: "index_mensa_table_views_on_config", using: :gin
    t.index ["table_name"], name: "index_mensa_table_views_on_table_name"
    t.index ["user_id"], name: "index_mensa_table_views_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "distribuo_downloads", "distribuo_releases"
  add_foreign_key "mensa_exports", "mensa_table_views", column: "table_view_id"
  add_foreign_key "mensa_exports", "users"
  add_foreign_key "mensa_table_views", "users"
end
