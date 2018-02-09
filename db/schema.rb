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

ActiveRecord::Schema.define(version: 20180209104832) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "logo"
    t.string   "country"
    t.string   "city"
    t.string   "address"
    t.string   "zip"
    t.string   "email"
    t.integer  "phone"
    t.string   "homepage"
    t.string   "business_type"
    t.string   "employees"
    t.string   "turnover"
    t.string   "established"
    t.text     "introduction"
    t.string   "language"
    t.string   "user"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "unit"
    t.float    "quantity"
    t.text     "description"
    t.integer  "request_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["request_id"], name: "index_items_on_request_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean  "messages"
    t.boolean  "join_company"
    t.boolean  "reject_compay"
    t.boolean  "participate_request"
    t.boolean  "new_bid"
    t.boolean  "not_participate_request"
    t.boolean  "invit_request"
    t.boolean  "changed_request"
    t.boolean  "reminder_end"
    t.boolean  "request_decision"
    t.boolean  "label_tender_scoring"
    t.boolean  "submitted_requisition"
    t.boolean  "messages_requisition"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "type"
    t.boolean  "enable_attatch"
    t.boolean  "mandatory"
    t.string   "options"
    t.integer  "request_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["request_id"], name: "index_questions_on_request_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string   "name"
    t.datetime "end_time"
    t.text     "description"
    t.string   "attach"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "categories"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_suppliers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "name"
    t.integer  "phone"
    t.integer  "mobile"
    t.string   "job_title"
    t.string   "language"
    t.string   "timezone"
    t.string   "country"
    t.string   "company"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
