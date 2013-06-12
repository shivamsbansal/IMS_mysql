class CreateLaptops < ActiveRecord::Migration
  def change
    create_table :laptops do |t|
      t.string :brand
      t.string :model
      t.decimal :cpuSpeed
      t.integer :ram

      t.timestamps
    end
  end
end
