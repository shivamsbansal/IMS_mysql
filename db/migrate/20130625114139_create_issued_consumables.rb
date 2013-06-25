class CreateIssuedConsumables < ActiveRecord::Migration
  def change
    create_table :issued_consumables do |t|
    	t.integer :stock_id
    	t.integer :associate_id
    	t.date :dateOfIssue
      t.timestamps
    end
  end
end
