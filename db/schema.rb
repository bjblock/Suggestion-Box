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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120416082127) do

  create_table "invitation_keys", :force => true do |t|
    t.integer  "suggestion_box_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "key"
  end

  add_index "invitation_keys", ["suggestion_box_id"], :name => "index_invitation_keys_on_suggestion_box_id"

  create_table "suggestion_boxes", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "by_invite_only"
    t.boolean  "votable"
    t.boolean  "anonymous_suggestions"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.boolean  "open",                  :default => true
  end

  add_index "suggestion_boxes", ["organization_id"], :name => "index_suggestion_boxes_on_organization_id"
  add_index "suggestion_boxes", ["user_id"], :name => "index_suggestion_boxes_on_user_id"

  create_table "suggestions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "link"
    t.boolean  "anonymous"
    t.integer  "total_votes",       :default => 0
    t.integer  "total_score",       :default => 0
    t.float    "average_score",     :default => 0.0
    t.integer  "suggestion_box_id"
    t.integer  "user_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "suggestions", ["suggestion_box_id"], :name => "index_suggestions_on_suggestion_box_id"
  add_index "suggestions", ["user_id"], :name => "index_suggestions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "administrator",   :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "score"
    t.text     "comment"
    t.integer  "suggestion_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votes", ["suggestion_id"], :name => "index_votes_on_suggestion_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
