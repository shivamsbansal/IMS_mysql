class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :idRegion
      t.string :nameRegion
      t.string :idParent

      t.timestamps
    end
  end
end
