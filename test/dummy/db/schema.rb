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

ActiveRecord::Schema.define(version: 20_201_118_143_143) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'
  enable_extension 'uuid-ossp'

  create_table 'distribuo_apps', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'release_type'
    t.string 'operating_system'
    t.string 'mobiliable_type'
    t.uuid 'mobiliable_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[mobiliable_type mobiliable_id], name: 'index_app_on_mobiliable'
  end

  create_table 'distribuo_downloads', force: :cascade do |t|
    t.uuid 'distribuo_release_id', null: false
    t.string 'ip'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['distribuo_release_id'], name: 'index_distribuo_downloads_on_distribuo_release_id'
  end

  create_table 'distribuo_releases', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'app_id'
    t.integer 'position'
    t.string 'version'
    t.text 'notes'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'build_number'
    t.index ['app_id'], name: 'index_distribuo_releases_on_app_id'
  end

  add_foreign_key 'distribuo_downloads', 'distribuo_releases'
end
