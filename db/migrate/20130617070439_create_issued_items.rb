class CreateIssuedItems < ActiveRecord::Migration
  def change
    create_table :issued_items do |t|
    	t.integer :asset_id
    	t.integer :associate_id
    	t.date :dateOfIssue
    	t.integer :quantity

      t.timestamps
    end
  end
end
