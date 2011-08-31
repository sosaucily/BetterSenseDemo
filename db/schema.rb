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

ActiveRecord::Schema.define(:version => 20110830230201) do

  create_table "accounts", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iqeinfos", :force => true do |t|
    t.text     "results"
    t.integer  "videotimemillis"
    t.string   "hashstring"
    t.string   "matcheditem"
    t.string   "colors"
    t.string   "imagepath"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iqx"
    t.integer  "iqy"
    t.integer  "iqwidth"
    t.integer  "iqheight"
    t.integer  "cx"
    t.integer  "cy"
    t.integer  "cwidth"
    t.integer  "xheight"
    t.integer  "cradius"
    t.boolean  "send_to_crowd",   :default => false
    t.datetime "processing",      :default => '2011-07-27 16:47:33'
    t.boolean  "complete",        :default => false
    t.string   "cdescription"
    t.string   "cproducturl"
    t.string   "ccompanyurl"
  end

  create_table "network_types", :force => true do |t|
    t.string   "name"
    t.string   "company_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "networks", :force => true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.integer  "network_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "name"
    t.integer  "lengthmillis"
    t.string   "description"
    t.string   "hashstring"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filepath"
    t.integer  "res_x",        :default => 480
    t.integer  "res_y",        :default => 360
    t.boolean  "viewable",     :default => false
    t.integer  "account_id"
  end

end
