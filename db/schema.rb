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

ActiveRecord::Schema.define(version: 20160126091537) do

  create_table "approvals", force: true do |t|
    t.integer  "inspection_schedule_id"
    t.binary   "signature"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "approvals", ["inspection_schedule_id"], name: "index_approvals_on_inspection_schedule_id"

  create_table "checkresults", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checks", force: true do |t|
    t.integer  "weather_id"
    t.integer  "exterior_id"
    t.integer  "tone_id"
    t.integer  "stain_id"
    t.integer  "inspection_result_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checks", ["weather_id"], name: "index_checks_on_weather_id"

  create_table "comments", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["topic_id"], name: "index_comments_on_topic_id"

  create_table "companies", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "equipment", force: true do |t|
    t.string   "name"
    t.integer  "system_model_id"
    t.integer  "place_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "equipment", ["company_id"], name: "index_equipment_on_company_id"
  add_index "equipment", ["place_id"], name: "index_equipment_on_place_id"
  add_index "equipment", ["system_model_id"], name: "index_equipment_on_system_model_id"

  create_table "flags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infomsgs", force: true do |t|
    t.date     "effective_date"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspection_periods", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspection_requests", force: true do |t|
    t.integer  "service_id"
    t.integer  "inspect_schedule_id"
    t.date     "schedule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inspection_requests", ["inspect_schedule_id"], name: "index_inspection_requests_on_inspect_schedule_id"
  add_index "inspection_requests", ["service_id"], name: "index_inspection_requests_on_service_id"

  create_table "inspection_results", force: true do |t|
    t.integer  "inspection_schedule_id"
    t.integer  "user_id"
    t.decimal  "latitude",               precision: 11, scale: 8
    t.decimal  "longitude",              precision: 11, scale: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inspection_results", ["inspection_schedule_id"], name: "index_inspection_results_on_inspection_schedule_id"
  add_index "inspection_results", ["user_id"], name: "index_inspection_results_on_user_id"

  create_table "inspection_schedules", force: true do |t|
    t.string   "targetyearmonth"
    t.integer  "equipment_id"
    t.integer  "status_id"
    t.integer  "user_id"
    t.integer  "result_id"
    t.date     "processingdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inspection_schedules", ["equipment_id"], name: "index_inspection_schedules_on_equipment_id"
  add_index "inspection_schedules", ["result_id"], name: "index_inspection_schedules_on_result_id"
  add_index "inspection_schedules", ["status_id"], name: "index_inspection_schedules_on_status_id"
  add_index "inspection_schedules", ["user_id"], name: "index_inspection_schedules_on_user_id"

  create_table "measurements", force: true do |t|
    t.integer  "metercount"
    t.decimal  "testervalue",          precision: 5, scale: 2
    t.integer  "point"
    t.integer  "inspection_result_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.integer  "inspection_result_id"
    t.text     "memo"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["inspection_result_id"], name: "index_notes_on_inspection_result_id"

  create_table "places", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "system_models", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "title"
    t.string   "name"
    t.text     "description"
    t.integer  "flag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["flag_id"], name: "index_topics_on_flag_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "userid"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weathers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
