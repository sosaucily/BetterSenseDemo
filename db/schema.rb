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

ActiveRecord::Schema.define(:version => 20110622180156) do

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
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

end
