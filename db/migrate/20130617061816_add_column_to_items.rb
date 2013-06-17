class AddColumnToItems < ActiveRecord::Migration
  def change
  	add_column :items, :assetType, :string
  end
end
