class AddIndex < ActiveRecord::Migration
  def change
  	add_index :assets, :stock_id
  	add_index :associates, :station_id
  	add_index :issued_consumables, :associate_id
  	add_index :issued_consumables, :stock_id
  	add_index :issued_items, :asset_id
  	add_index :issued_items, :associate_id
  	add_index :items, :vendor_id
  	add_index :items, :category_id
  	add_index :stations, :territory_id
  	add_index :stocks, :station_id
  	add_index :stocks, :item_id
  	add_index :territories, :region_id
  	add_index :transfers, :from
  	add_index :transfers, :to
  	add_index :transfers, :stock_id
  	add_index :users, [:level_id, :level_type]
  	add_index :vendors, :category_id

  end
end
