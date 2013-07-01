class DropLaptop < ActiveRecord::Migration
  def change
  	drop_table :laptops
  	drop_table :clothings
  end
end
