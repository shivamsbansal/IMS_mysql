class CreateChalanNumbers < ActiveRecord::Migration
  def change
    create_table :chalan_numbers do |t|
    	t.string :chalanNo, limit: 8
      t.timestamps
    end
  end
end
