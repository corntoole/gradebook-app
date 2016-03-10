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

ActiveRecord::Schema.define(version: 2) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "surname",          limit: 255
    t.string   "email",            limit: 255
    t.string   "crypted_password", limit: 255
    t.string   "role",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", id: false, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                                               default: true
    t.integer  "id",                  limit: 4,                                           null: false
    t.string   "title",               limit: 160
    t.string   "extended_title",      limit: 512
    t.decimal  "max_points",                      precision: 6, scale: 2, default: 100.0
    t.integer  "course_id",           limit: 4
    t.integer  "grade_categories_id", limit: 4,                                           null: false
  end

  add_index "assignments", ["grade_categories_id"], name: "fk_assignments_grade_categories1_idx", using: :btree

  create_table "assignments_has_courses", id: false, force: :cascade do |t|
    t.integer "assignments_id",                  limit: 4, null: false
    t.integer "assignments_grade_categories_id", limit: 4, null: false
    t.integer "courses_id",                      limit: 4, null: false
  end

  add_index "assignments_has_courses", ["assignments_id", "assignments_grade_categories_id"], name: "fk_assignments_has_courses_assignments1_idx", using: :btree
  add_index "assignments_has_courses", ["courses_id"], name: "fk_assignments_has_courses_courses1_idx", using: :btree

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",              default: true
    t.string   "title",      limit: 160
  end

  create_table "courses_has_students", id: false, force: :cascade do |t|
    t.integer "courses_id",  limit: 4, null: false
    t.integer "students_id", limit: 4, null: false
  end

  add_index "courses_has_students", ["courses_id"], name: "fk_courses_has_students_courses_idx", using: :btree
  add_index "courses_has_students", ["students_id"], name: "fk_courses_has_students_students1_idx", using: :btree

  create_table "grade_categories", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                                                 default: true
    t.string   "title",                  limit: 45
    t.decimal  "weight",                            precision: 4, scale: 2, default: 1.0
    t.integer  "no_assignments_to_drop", limit: 4,                          default: 0
    t.integer  "courses_id",             limit: 4,                                         null: false
  end

  add_index "grade_categories", ["courses_id"], name: "fk_grade_categories_courses1_idx", using: :btree

  create_table "graded_activities", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                                                         default: true
    t.decimal  "grade",                                     precision: 6, scale: 2
    t.integer  "courses_id",                      limit: 4,                                        null: false
    t.integer  "assignments_id",                  limit: 4,                                        null: false
    t.integer  "assignments_grade_categories_id", limit: 4,                                        null: false
    t.integer  "students_id",                     limit: 4,                                        null: false
  end

  add_index "graded_activities", ["assignments_id", "assignments_grade_categories_id"], name: "fk_graded_activities_assignments1_idx", using: :btree
  add_index "graded_activities", ["courses_id"], name: "fk_graded_activities_courses1_idx", using: :btree
  add_index "graded_activities", ["students_id"], name: "fk_graded_activities_students1_idx", using: :btree

  create_table "students", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",                   default: true
    t.string   "school_idnumber", limit: 45
    t.string   "first_name",      limit: 100
    t.string   "middle_name",     limit: 45
    t.string   "last_name",       limit: 100
    t.string   "email",           limit: 160
  end

  add_foreign_key "assignments", "grade_categories", column: "grade_categories_id", name: "fk_assignments_grade_categories1"
  add_foreign_key "assignments_has_courses", "assignments", column: "assignments_grade_categories_id", primary_key: "grade_categories_id", name: "fk_assignments_has_courses_assignments1"
  add_foreign_key "assignments_has_courses", "assignments", column: "assignments_id", name: "fk_assignments_has_courses_assignments1"
  add_foreign_key "assignments_has_courses", "courses", column: "courses_id", name: "fk_assignments_has_courses_courses1"
  add_foreign_key "courses_has_students", "courses", column: "courses_id", name: "fk_courses_has_students_courses"
  add_foreign_key "courses_has_students", "students", column: "students_id", name: "fk_courses_has_students_students1"
  add_foreign_key "grade_categories", "courses", column: "courses_id", name: "fk_grade_categories_courses1"
  add_foreign_key "graded_activities", "assignments", column: "assignments_grade_categories_id", primary_key: "grade_categories_id", name: "fk_graded_activities_assignments1"
  add_foreign_key "graded_activities", "assignments", column: "assignments_id", name: "fk_graded_activities_assignments1"
  add_foreign_key "graded_activities", "courses", column: "courses_id", name: "fk_graded_activities_courses1"
  add_foreign_key "graded_activities", "students", column: "students_id", name: "fk_graded_activities_students1"
end
