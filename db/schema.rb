# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090721195826) do

  create_table "project_volunteers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_volunteers", ["project_id"], :name => "index_project_volunteers_on_project_id"
  add_index "project_volunteers", ["user_id"], :name => "index_project_volunteers_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "org_name"
    t.text     "org_details"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "website"
    t.text     "description"
    t.string   "access_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.string   "status"
    t.date     "deadline"
  end

  add_index "projects", ["status"], :name => "index_projects_on_status"

  create_table "taggings", :force => true do |t|
    t.integer "tag_id"
    t.string  "taggable_type", :default => ""
    t.integer "taggable_id"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name", :default => ""
    t.string "kind", :default => ""
  end

  add_index "tags", ["name", "kind"], :name => "index_tags_on_name_and_kind"

  create_table "users", :force => true do |t|
    t.string   "email",                                    :null => false
    t.string   "crypted_password",                         :null => false
    t.string   "password_salt",                            :null => false
    t.string   "persistence_token",                        :null => false
    t.string   "single_access_token",                      :null => false
    t.string   "perishable_token",                         :null => false
    t.string   "name"
    t.date     "availability_starts"
    t.date     "availability_ends"
    t.integer  "hours_per_week"
    t.text     "notes"
    t.boolean  "admin",                 :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "receive_notifications", :default => false
    t.string   "aliases"
  end

end
