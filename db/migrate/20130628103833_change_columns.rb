class ChangeColumns < ActiveRecord::Migration
  def change
  	add_column :issued_consumables, :quantity , :integer
  	remove_column :stocks, :alert
  	add_column :stations, :addr1, :string
  	add_column :stations, :addr2, :string
  	add_column :stations, :pincode, :integer
  	add_column :stations, :contactDetails, :string
  end
end
