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

ActiveRecord::Schema.define(version: 20170630115944) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ms_category", id: :integer, limit: 2, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 80, null: false
    t.integer "parentId", limit: 2, default: 0, null: false, unsigned: true
    t.text "children", limit: 16777215, null: false
    t.index ["parentId"], name: "parentId"
  end

  create_table "ms_product", id: :integer, limit: 3, unsigned: true, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "categoryId", limit: 2, default: 0, null: false, unsigned: true
    t.string "sale", null: false
    t.string "author", null: false
    t.integer "rating", limit: 2, default: 0, null: false, unsigned: true
    t.string "series", null: false
    t.string "cover", limit: 50, null: false
    t.string "ISBN", null: false
    t.string "url", null: false
    t.string "producer", null: false
    t.integer "new", limit: 1, default: 0, null: false, unsigned: true
    t.string "picture", null: false
    t.string "visible", limit: 1, default: "Y", null: false
    t.integer "volume", limit: 1, default: 0, null: false, unsigned: true
    t.boolean "availabilityCode", default: true, null: false, unsigned: true
    t.string "name", null: false
    t.text "description", limit: 16777215, null: false
    t.integer "topCategoryId", limit: 2, default: 0, null: false, unsigned: true
    t.string "book", limit: 1, default: "Y", null: false
    t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false, unsigned: true
    t.string "md5", limit: 32, null: false
    t.string "year", limit: 10
    t.integer "pages", limit: 2, default: 0, null: false, unsigned: true
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
