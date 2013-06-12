class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :nameVendor
      t.string :email
      t.integer :phone, :limit => 8

      t.timestamps
    end
  end
end
