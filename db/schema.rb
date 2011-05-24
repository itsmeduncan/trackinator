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

ActiveRecord::Schema.define(:version => 20110524010503) do

  create_table "victims", :force => true do |t|
    t.string   "name",                                          :null => false
    t.string   "url",                                           :null => false
    t.string   "selector",                                      :null => false
    t.integer  "interval",   :default => 3600,                  :null => false
    t.datetime "last_visit", :default => '2011-05-24 01:04:32'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", :force => true do |t|
    t.float    "value"
    t.integer  "status"
    t.integer  "victim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
