class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :nameCategory

      t.timestamps
    end
  end
end
