ActiveRecord::Schema.define(version: 12) do

  create_table "achievements", force: true do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "achievements", ["badge_id"], name: "index_achievements_on_badge_id"
  add_index "achievements", ["user_id"], name: "index_achievements_on_user_id"

  create_table "answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["task_id"], name: "index_answers_on_task_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "badges", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",     default: true
  end

  create_table "categories_tasks", id: false, force: true do |t|
    t.integer "category_id", null: false
    t.integer "task_id",     null: false
  end

  add_index "categories_tasks", ["category_id", "task_id"], name: "index_categories_tasks_on_category_id_and_task_id"
  add_index "categories_tasks", ["task_id", "category_id"], name: "index_categories_tasks_on_task_id_and_category_id"

  create_table "choices", force: true do |t|
    t.integer  "task_id"
    t.text     "text"
    t.text     "explanation"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "points"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["category_id"], name: "index_skills_on_category_id"
  add_index "skills", ["user_id"], name: "index_skills_on_user_id"

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "query"
    t.text     "excerpt"
    t.integer  "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points",               default: 0
    t.boolean  "admin",                default: false
  end

end
