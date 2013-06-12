class ChangeStaionRegion < ActiveRecord::Migration
  def change
  	rename_column :stations, :region_id, :territory_id
  end
end
