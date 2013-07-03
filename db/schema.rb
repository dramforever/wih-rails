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

ActiveRecord::Schema.define(version: 20130703114427) do

  create_table "images", force: true do |t|
    t.integer  "vote"
    t.integer  "win"
    t.float    "rate"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.integer  "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_inspect"
  end

  add_index "images", ["gender"], name: "index_images_on_gender"
  add_index "images", ["has_inspect"], name: "index_images_on_has_inspect"
  add_index "images", ["img_file_name"], name: "index_images_on_img_file_name"
  add_index "images", ["rate"], name: "index_images_on_rate"

end
