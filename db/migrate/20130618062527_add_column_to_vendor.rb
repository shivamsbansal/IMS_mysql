class AddColumnToVendor < ActiveRecord::Migration
  def change
  	add_column :vendors, :itemCategory, :string, :limit => 30
  end
end
