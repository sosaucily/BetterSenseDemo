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

ActiveRecord::Schema.define(:version => 20120323180758) do

  create_table "accounts", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ad_sets", :force => true do |t|
    t.string   "name"
    t.integer  "video_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.string   "email",                             :default => "", :null => false
    t.string   "encrypted_password", :limit => 128, :default => "", :null => false
    t.integer  "failed_attempts",                   :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "sign_in_count",                     :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "zone_id"
    t.string   "image_url"
    t.integer  "time_millis"
    t.integer  "duration_millis"
    t.integer  "ad_set_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "advertiser_id"
    t.string   "ad_pic_file_name"
    t.string   "ad_pic_content_type"
    t.integer  "ad_pic_file_size"
    t.datetime "ad_pic_updated_at"
    t.string   "ad_pic_fingerprint"
    t.integer  "iqeinfo_id"
    t.integer  "click_count"
    t.text     "html_src"
    t.string   "overlay_content_type"
    t.integer  "campaign_id"
    t.integer  "impress_count"
  end

  create_table "advertisers", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "budget"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "assigned_cpm"
    t.integer  "account_id"
  end

  create_table "carts", :force => true do |t|
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

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
    t.datetime "processing",      :default => '2011-09-29 22:57:12'
    t.boolean  "complete",        :default => false
    t.string   "cdescription"
    t.string   "cproducturl"
    t.string   "ccompanyurl"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "video_id"
    t.integer  "cart_id"
    t.string   "quality"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.string   "email"
    t.string   "pay_type"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "player_url"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.integer  "player_type_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "t1" because of following StandardError
#   Unknown type '' for column 'a'

  create_table "traffic_watchers", :force => true do |t|
    t.string   "source_ip"
    t.string   "session_id"
    t.string   "path"
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
    t.integer  "account_id"
    t.string   "authentication_token"
    t.string   "secret_key"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
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
    t.integer  "res_x",                  :default => 480
    t.integer  "res_y",                  :default => 360
    t.boolean  "viewable",               :default => false
    t.integer  "account_id"
    t.string   "vid_file_file_name"
    t.string   "vid_file_content_type"
    t.integer  "vid_file_file_size"
    t.datetime "vid_file_updated_at"
    t.string   "status",                 :default => "new"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
  end

  create_table "zone_types", :force => true do |t|
    t.string   "name"
    t.integer  "width"
    t.text     "description"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zones", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "zone_type_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "width"
    t.integer  "height"
  end

end
