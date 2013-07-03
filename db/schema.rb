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

ActiveRecord::Schema.define(:version => 20130703173434) do

  create_table "assets", :force => true do |t|
    t.string   "assetSrNo",  :limit => 40
    t.integer  "stock_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "state",      :limit => 10
  end

  create_table "associates", :force => true do |t|
    t.string   "name",          :limit => 50
    t.string   "email",         :limit => 30
    t.date     "dateOfJoining"
    t.integer  "station_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "nameCategory"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "chalan_numbers", :force => true do |t|
    t.string   "chalanNo",   :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "issued_consumables", :force => true do |t|
    t.integer  "stock_id"
    t.integer  "associate_id"
    t.date     "dateOfIssue"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "quantity"
  end

  create_table "issued_items", :force => true do |t|
    t.integer  "asset_id"
    t.integer  "associate_id"
    t.date     "dateOfIssue"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "nameItem"
    t.integer  "lifeCycle"
    t.integer  "cost"
    t.integer  "leadTime"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "codeItem"
    t.integer  "vendor_id"
    t.integer  "minimumStock"
    t.string   "assetType"
    t.integer  "category_id"
    t.string   "brand",        :limit => 50
    t.string   "distinction",  :limit => 50
    t.string   "model",        :limit => 50
  end

  create_table "regions", :force => true do |t|
    t.string   "idRegion"
    t.string   "nameRegion"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stations", :force => true do |t|
    t.string   "nameStation"
    t.integer  "territory_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "addr1"
    t.string   "addr2"
    t.integer  "pincode"
    t.string   "contactDetails"
  end

  create_table "stocks", :force => true do |t|
    t.integer  "item_id"
    t.integer  "station_id"
    t.string   "poId",            :limit => 20
    t.date     "poDate"
    t.string   "invoiceNo",       :limit => 40
    t.date     "invoiceDate"
    t.integer  "warrantyPeriod"
    t.integer  "initialStock"
    t.integer  "presentStock"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.boolean  "inTransit",                     :default => false
    t.string   "comments"
    t.integer  "issuedStock"
    t.integer  "destroyedStock"
    t.integer  "soldStock"
    t.integer  "transferedStock"
    t.integer  "soldValue"
  end

  create_table "territories", :force => true do |t|
    t.string   "nameTerritory"
    t.integer  "region_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "idTerritory"
  end

  create_table "transfers", :force => true do |t|
    t.integer  "from"
    t.integer  "to"
    t.date     "dateOfDispatch"
    t.date     "dateOfReceipt"
    t.integer  "stock_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "comments"
    t.string   "chalanNo"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "phone",           :limit => 8
    t.string   "password_digest"
    t.boolean  "admin"
    t.string   "remember_token"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "level_id"
    t.string   "level_type"
  end

  create_table "vendors", :force => true do |t|
    t.string   "nameVendor"
    t.string   "email"
    t.integer  "phone",       :limit => 8
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "category_id"
  end

end
