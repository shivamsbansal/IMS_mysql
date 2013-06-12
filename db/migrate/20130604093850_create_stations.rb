class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string	:nameStation
      t.integer	:region_id

      t.timestamps
    end
  end
end
