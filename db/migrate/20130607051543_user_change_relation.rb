class UserChangeRelation < ActiveRecord::Migration
  def change
  	change_table :users do |t|
	  	t.remove :station_id
	  	t.references :level, polymorphic: true
	  end
  end
end
