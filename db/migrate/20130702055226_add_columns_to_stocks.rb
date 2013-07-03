class AddColumnsToStocks < ActiveRecord::Migration
  def change
  	add_column :stocks, :issuedStock, :integer
  	add_column :stocks, :destroyedStock, :integer
  	add_column :stocks, :soldStock, :integer
  	add_column :stocks, :transferedStock, :integer
  	add_column :stocks, :soldValue, :integer
  end
end
