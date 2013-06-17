class CreateAssociates < ActiveRecord::Migration
  def change
    create_table :associates do |t|
    	t.string :name, limit: 50
    	t.string :email, limit: 30
    	t.date :dateOfJoining
    	t.integer :station_id
      t.timestamps
    end
  end
end
