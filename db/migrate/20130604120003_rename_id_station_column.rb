class RenameIdStationColumn < ActiveRecord::Migration
  def change
  	rename_column :users, :idStation, :station_id
  end
end
