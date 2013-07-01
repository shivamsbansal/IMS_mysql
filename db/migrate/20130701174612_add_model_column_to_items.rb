class AddModelColumnToItems < ActiveRecord::Migration
  def change
  	add_column :items, :model, :string, :limit => 50
  end
end
