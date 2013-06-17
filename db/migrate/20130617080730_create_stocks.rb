class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
    	t.integer :item_id
    	t.integer :station_id
    	t.string 	:poId, limit: 20
    	t.date 		:poDate
    	t.string 	:invoiceNo, limit: 40
    	t.date  	:invoiceDate
    	t.integer :warrantyPeriod
    	t.integer	:initialStock
    	t.integer :presentStock
    	t.string 	:issuedReason

      t.timestamps
    end
  end
end
