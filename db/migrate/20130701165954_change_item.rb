class ChangeItem < ActiveRecord::Migration
  def change
  	remove_column :items, :itemCategory_id
  	remove_column :items, :itemCategory_type
  end
end
