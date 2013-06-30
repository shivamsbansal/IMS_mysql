class RemoveColumnIssuedReason < ActiveRecord::Migration
  def change
  	remove_column :stocks, :issuedReason
  end
end
