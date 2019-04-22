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

ActiveRecord::Schema.define(:version => 20120525004816) do

  create_table "collectors", :force => true do |t|
    t.string   "ip",                             :null => false
    t.integer  "uptime",                         :null => false
    t.integer  "status",                         :null => false
    t.string   "host_os",                        :null => false
    t.string   "host_la",                        :null => false
    t.integer  "storage_used",                   :null => false
    t.integer  "storage_free",                   :null => false
    t.integer  "memory_used",                    :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "is_blocked",   :default => 0,    :null => false
    t.datetime "checked_at"
    t.integer  "url_port",     :default => 8081, :null => false
  end

  add_index "collectors", ["ip"], :name => "index_collectors_on_ip", :unique => true

  create_table "downloads", :force => true do |t|
    t.integer  "collector_id",                :null => false
    t.integer  "user_id",                     :null => false
    t.string   "url",                         :null => false
    t.integer  "status",       :default => 1, :null => false
    t.integer  "type",                        :null => false
    t.string   "title",                       :null => false
    t.string   "author",                      :null => false
    t.integer  "length",                      :null => false
    t.integer  "size",                        :null => false
    t.integer  "progress",                    :null => false
    t.string   "quality",                     :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "thumbnail"
    t.integer  "bitrate"
  end

  add_index "downloads", ["collector_id", "user_id", "url", "status", "type", "title", "author", "length", "size", "progress", "quality"], :name => "index_downloads_composite2", :unique => true
  add_index "downloads", ["collector_id", "user_id", "url"], :name => "index_downloads_composite1", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                          :null => false
    t.integer  "is_confirmed",    :default => 0, :null => false
    t.integer  "is_admin",        :default => 0, :null => false
    t.integer  "is_blocked",      :default => 0, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "password_digest",                :null => false
    t.string   "remember_token"
    t.datetime "last_login_at"
  end

  add_index "users", ["email", "is_confirmed", "is_admin", "is_blocked", "updated_at", "created_at"], :name => "index_users_composite1", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
