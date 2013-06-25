class AddColumnStock < ActiveRecord::Migration
 	def change
 		add_column :stocks, :inTransit, :boolean, :default => false
 	end
end
