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

ActiveRecord::Schema.define(version: 20140826195941) do

  create_table "participations", id: false, force: true do |t|
    t.integer "user_id",    null: false
    t.integer "project_id", null: false
    t.boolean "is_leader"
  end

  add_index "participations", ["project_id"], name: "index_participations_on_project_id"
  add_index "participations", ["user_id"], name: "index_participations_on_user_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "schedules_id"
  end

  add_index "projects", ["schedules_id"], name: "index_projects_on_schedules_id"

  create_table "schedules", force: true do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "end"
    t.string   "place"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string "name"
    t.string "email"
  end

end
