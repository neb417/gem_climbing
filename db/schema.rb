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

ActiveRecord::Schema.define(version: 2022_08_29_002149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crags", force: :cascade do |t|
    t.string "crag_name"
    t.boolean "reservation_required"
    t.integer "elevation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string "route_name"
    t.boolean "sport_route"
    t.boolean "trad_route"
    t.integer "pitches"
    t.string "grade"
    t.bigint "crag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crag_id"], name: "index_routes_on_crag_id"
  end

  add_foreign_key "routes", "crags"
end
