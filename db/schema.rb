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

ActiveRecord::Schema.define(version: 2021_03_24_175505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.integer "estimated_value_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "collections_items", id: false, force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.bigint "item_id", null: false
    t.index ["collection_id"], name: "index_collections_items_on_collection_id"
    t.index ["item_id"], name: "index_collections_items_on_item_id"
  end

  create_table "data_fetches", force: :cascade do |t|
    t.json "data"
    t.datetime "fetched_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events_items", id: false, force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_events_items_on_event_id"
    t.index ["item_id"], name: "index_events_items_on_item_id"
  end

  create_table "features", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "features_items", id: false, force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "feature_id", null: false
    t.index ["feature_id"], name: "index_features_items_on_feature_id"
    t.index ["item_id"], name: "index_features_items_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "number"
    t.string "title"
    t.string "form_factor"
    t.string "features"
    t.string "inner_case_count"
    t.string "master_case_quantity"
    t.string "status"
    t.string "image_url"
    t.bigint "category_id"
    t.bigint "license_id"
    t.bigint "brand_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["license_id"], name: "index_items_on_license_id"
  end

  create_table "licenses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
