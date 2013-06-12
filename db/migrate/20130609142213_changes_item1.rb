class ChangesItem1 < ActiveRecord::Migration
  def change
  	add_column :items, :codeItem, :string
  	add_column :items, :vendor_id, :integer 
  end
end
