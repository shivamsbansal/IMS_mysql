class AddDistinctionColumnToItems < ActiveRecord::Migration
  def change
  	add_column :items, :brand, :string, :limit => 50
  	add_column :items, :distinction, :string, :limit => 50
  end
end
