class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :nameItem
      t.integer :lifeCycle
      t.integer :cost
      t.integer :leadTime
      t.references :itemCategory, polymorphic: true

      t.timestamps
    end
  end
end
