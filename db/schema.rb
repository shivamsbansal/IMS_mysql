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

ActiveRecord::Schema.define(:version => 20130629231313) do

  create_table "assets", :force => true do |t|
    t.string   "assetSrNo",  :limit => 20
    t.integer  "stock_id"
    t.boolean  "issued"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "associates", :force => true do |t|
    t.string   "name",          :limit => 50
    t.string   "email"      
    t.date     "dateOfJoining"
    t.integer  "station_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "nameCategory",  :limit => 30
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "chalan_numbers", :force => true do |t|
    t.string   "chalanNo",   :limit => 10
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "clothings", :force => true do |t|
    t.string   "clothCategory"
    t.string   "brand"
    t.string   "size"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
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
    t.string   "nameItem"  , :limit => 50
    t.integer  "lifeCycle"
    t.integer  "cost"
    t.integer  "leadTime"
    t.integer  "itemCategory_id"
    t.string   "itemCategory_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "codeItem", :limit => 10
    t.integer  "vendor_id"
    t.integer  "minimumStock"
    t.string   "assetType", :limit =>15
  end

  create_table "laptops", :force => true do |t|
    t.string   "brand"
    t.string   "model"
    t.decimal  "cpuSpeed",   :precision => 10, :scale => 0
    t.integer  "ram"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "idRegion", :limit => 10
    t.string   "nameRegion", :limit => 30
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stations", :force => true do |t|
    t.string   "nameStation",     :limit => 30
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
    t.string   "poId",           :limit => 20
    t.date     "poDate"
    t.string   "invoiceNo",      :limit => 20
    t.date     "invoiceDate"
    t.integer  "warrantyPeriod"
    t.integer  "initialStock"
    t.integer  "presentStock"
    t.string   "issuedReason"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.boolean  "inTransit",                    :default => false
    t.string   "comments"
  end

  create_table "territories", :force => true do |t|
    t.string   "nameTerritory", :limit => 30
    t.integer  "region_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "idTerritory",   :limit => 10
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
    t.string   "chalanNo", :limit => 10
  end

  create_table "users", :force => true do |t|
    t.string   "name", :limit => 50
    t.string   "email"
    t.integer  "phone",           :limit => 8
    t.string   "password_digest"
    t.boolean  "admin"
    t.string   "remember_token"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "level_id"
    t.string   "level_type", :limit => 30
  end

  create_table "vendors", :force => true do |t|
    t.string   "nameVendor", :limit => 50
    t.string   "email"
    t.integer  "phone",        :limit => 8
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "itemCategory", :limit => 30
  end

end
