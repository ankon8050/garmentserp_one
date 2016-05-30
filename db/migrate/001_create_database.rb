class CreateDatabase < ActiveRecord::Migration
  def self.up
#######################################################
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

ActiveRecord::Schema.define(version: 1) do

  create_table "buyer_profile_table", primary_key: "buyer_id", force: :cascade do |t|
    t.string "buying_house_name",            limit: 60
    t.string "authorized_merchandizer_name", limit: 100
    t.string "authorizer_name",              limit: 30
    t.string "buyer_contact_number",         limit: 20
  end

  create_table "cutting_input_table", primary_key: "Id", force: :cascade do |t|
    t.string  "table_no",            limit: 4
    t.string  "per_hour_target",     limit: 6
    t.string  "style_tracking_code", limit: 255
    t.string  "complete_status",     limit: 15,  default: "Not complete"
    t.date    "input_date"
    t.date    "delivery_date"
    t.string  "working_hour",        limit: 4
    t.string  "last_day_output",     limit: 5
    t.integer "style_id",            limit: 4,   default: 0
    t.integer "buyer_id",            limit: 4,   default: 0
    t.string  "total_output",        limit: 10
    t.integer "lot_id",              limit: 4
    t.string  "remaining_output",    limit: 70
    t.string  "price_in",            limit: 50
    t.string  "per_day_target",      limit: 50
    t.string  "extra",               limit: 50
  end

  create_table "embroidery_table", primary_key: "Id", force: :cascade do |t|
    t.string "style_tracking_code", limit: 255
    t.string "total_send",          limit: 100
    t.date   "send_date"
    t.string "total_receive",       limit: 100
    t.date   "receive_date"
  end

  create_table "finishing_input_table", primary_key: "Id", force: :cascade do |t|
    t.string  "style_tracking_code", limit: 255
    t.string  "process",             limit: 10
    t.string  "table_no",            limit: 3
    t.string  "per_hour_target",     limit: 5
    t.string  "per_day_target",      limit: 100
    t.string  "total_finish",        limit: 100
    t.string  "complete_status",     limit: 15,  default: "Not complete"
    t.string  "remarks",             limit: 500
    t.date    "input_date"
    t.date    "delivery_date"
    t.integer "buyer_id",            limit: 4
    t.integer "lot_id",              limit: 4
    t.integer "style_id",            limit: 4
    t.string  "remaining_output",    limit: 50
    t.string  "last_day_output",     limit: 50
    t.string  "working_hour",        limit: 50
    t.string  "extra",               limit: 50
  end

  create_table "finishing_process", primary_key: "Id", force: :cascade do |t|
    t.string "process_name", limit: 30
  end

  create_table "lot_table", primary_key: "lot_id", force: :cascade do |t|
    t.string  "lot_tracking_code", limit: 255
    t.string  "lot_number",        limit: 255
    t.string  "order_status",      limit: 15,  default: "Not completed"
    t.string  "lc_no",             limit: 255, default: ""
    t.date    "order_date"
    t.date    "delivery_date"
    t.integer "buyer_id",          limit: 4,   default: 0
  end

  create_table "printing_table", primary_key: "Id", force: :cascade do |t|
    t.string "style_tracking_code", limit: 255
    t.string "total_send",          limit: 255
    t.string "send_date",           limit: 255
    t.date   "total_receive"
    t.date   "receive_date"
  end

  create_table "projects", primary_key: "Id", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "task", limit: 255
  end

  create_table "sewing_input_table", primary_key: "sewing_input_table_id", force: :cascade do |t|
    t.integer "buyer_id",         limit: 4
    t.integer "lot_id",           limit: 4
    t.integer "style_id",         limit: 4
    t.string  "ie_day_target",    limit: 50
    t.date    "create_date"
    t.string  "create_time",      limit: 10
    t.string  "complete_status",  limit: 20, default: "not complete"
    t.string  "hourly_target",    limit: 50
    t.string  "manpower",         limit: 50
    t.string  "total_smv",        limit: 50
    t.string  "remaining_target", limit: 50
    t.string  "last_day_output",  limit: 50
    t.string  "extra",            limit: 50
  end

  create_table "sewing_machine_list_table", primary_key: "sewing_machine_list_table_id", force: :cascade do |t|
    t.string "machine_name", limit: 20
  end

  add_index "sewing_machine_list_table", ["machine_name"], name: "machine_name", unique: true, using: :btree

  create_table "sewing_machine_process_details_table", primary_key: "sewing_machine_process_details_table_id", force: :cascade do |t|
    t.integer "sewing_input_table_id",  limit: 4
    t.string  "wise_target_part_one",   limit: 10
    t.string  "wise_target_part_two",   limit: 10
    t.string  "wise_target_part_three", limit: 255
    t.string  "machine_name",           limit: 10
    t.integer "machine_id",             limit: 4
    t.integer "total_machine",          limit: 4
    t.date    "create_date"
  end

  create_table "sewing_process_details_table", primary_key: "sewing_process_details_table_id", force: :cascade do |t|
    t.integer "sewing_process_table_id",      limit: 4
    t.integer "sewing_input_table_id",        limit: 4
    t.string  "smv",                          limit: 5
    t.string  "target",                       limit: 50
    t.integer "sewing_machine_list_table_id", limit: 4
    t.string  "attachment",                   limit: 10
    t.string  "work_station",                 limit: 50
    t.string  "operator",                     limit: 10
    t.string  "helper",                       limit: 10
    t.string  "remark",                       limit: 500
    t.string  "process_name",                 limit: 50
    t.string  "machine_name",                 limit: 10
  end

  create_table "sewing_process_table", primary_key: "sewing_process_table_id", force: :cascade do |t|
    t.string "process_name", limit: 100
  end

  add_index "sewing_process_table", ["process_name"], name: "process_name", unique: true, using: :btree

  create_table "style_table", primary_key: "style_id", force: :cascade do |t|
    t.string  "style_tracking_code", limit: 255
    t.string  "order_no",            limit: 255
    t.string  "style_no",            limit: 16
    t.string  "product_name",        limit: 50
    t.string  "color",               limit: 50
    t.string  "order_quantity",      limit: 50
    t.string  "size",                limit: 10
    t.string  "price",               limit: 100
    t.string  "total",               limit: 100
    t.date    "create_date"
    t.date    "delivery_date"
    t.string  "complete_status",     limit: 15,  default: "Not complete"
    t.string  "lot_tracking_code",   limit: 255
    t.integer "buyer_id",            limit: 4,   default: 0
    t.integer "lot_id",              limit: 4,   default: 0
  end

  create_table "user_table", primary_key: "Id", force: :cascade do |t|
    t.string "user_name",           limit: 255
    t.string "password",            limit: 255
    t.date   "user_create_date"
    t.string "user_designation",    limit: 100
    t.string "last_logged_in_time", limit: 20
    t.string "contact_info",        limit: 15
    t.string "picture_url",         limit: 255, default: "no_picture"
  end

end


########################
  end

  def self.down
    # drop all the tables if you really need
    # to support migration back to version 0
  end
end