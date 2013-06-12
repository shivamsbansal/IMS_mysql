class CreateClothings < ActiveRecord::Migration
  def change
    create_table :clothings do |t|
      t.string :type
      t.string :brand
      t.string :size

      t.timestamps
    end
  end
end
