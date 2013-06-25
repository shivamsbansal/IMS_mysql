class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
    	t.integer :from
    	t.integer :to
    	t.date :dateOfDispatch
    	t.date :dateOfReceipt
    	t.integer :stock_id
    	
      t.timestamps
    end
  end
end
