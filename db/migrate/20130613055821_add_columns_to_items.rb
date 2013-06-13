class AddColumnsToItems < ActiveRecord::Migration
  def change
  	add_column :items, :minimumStock, :integer 
  end
end
