class ChangeAsset < ActiveRecord::Migration
  def change
  	remove_column :assets, :issued
  	add_column :assets, :state, :string, :limit => 10
  end
end
