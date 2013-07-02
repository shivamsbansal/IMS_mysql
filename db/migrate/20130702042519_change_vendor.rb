class ChangeVendor < ActiveRecord::Migration
  def change
  	remove_column :vendors, :itemCategory
  	add_column :vendors, :category_id, :integer
  end
end
