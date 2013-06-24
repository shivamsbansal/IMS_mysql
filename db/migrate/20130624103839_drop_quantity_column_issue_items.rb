class DropQuantityColumnIssueItems < ActiveRecord::Migration
  def change
  	remove_column :issued_items, :quantity
  end
end
