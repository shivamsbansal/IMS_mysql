class AddLimitToChalanNo < ActiveRecord::Migration
  def change
  	change_column :transfers, :chalanNo, :string, :limit => 10
  end
end
