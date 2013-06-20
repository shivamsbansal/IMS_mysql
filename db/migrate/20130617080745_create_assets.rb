class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
    	t.string :assetSrNo, limit: 40
    	t.belongs_to :stock
    	t.boolean :issued

      t.timestamps
    end
  end
end
