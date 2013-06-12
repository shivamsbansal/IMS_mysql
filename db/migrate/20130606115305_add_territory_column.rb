class AddTerritoryColumn < ActiveRecord::Migration
  def change
  	add_column :territories, :idTerritory, :string
  end
end
