class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
    	t.string :assetSrNo, limit: 40
    	t.integer :stock_id
    	t.boolean :issued

      t.timestamps
    end
  end
end
