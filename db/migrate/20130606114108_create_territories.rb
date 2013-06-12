class CreateTerritories < ActiveRecord::Migration
  def change
    create_table :territories do |t|
      t.string :nameTerritory
      t.integer :region_id

      t.timestamps
    end
  end
end
