class DropRegionParent < ActiveRecord::Migration
  def change
  	remove_column :regions, :idParent
  end
end
