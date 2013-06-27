class Add < ActiveRecord::Migration
  def change
  	add_column :stocks, :comments, :string
  	add_column :transfers, :comments, :string
  	add_column :transfers, :chalanNo, :string
  end
end
