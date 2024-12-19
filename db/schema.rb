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

ActiveRecord::Schema[8.0].define(version: 2024_12_19_140442) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.integer "cook_time"
    t.integer "prep_time"
    t.string "ingredients", array: true
    t.decimal "ratings", precision: 4, scale: 2
    t.string "cuisine"
    t.string "category"
    t.string "author"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "keywords", null: false, array: true
    t.tsvector "ingredients_vector"
    t.index ["ingredients_vector"], name: "recipes_ingredients_vector_idx", using: :gin
    t.index ["keywords"], name: "index_recipes_on_keywords", using: :gin
  end
end
