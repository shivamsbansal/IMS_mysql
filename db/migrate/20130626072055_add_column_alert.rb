class AddColumnAlert < ActiveRecord::Migration
  def change
  	add_column :stocks, :alert, :boolean
  end
end
