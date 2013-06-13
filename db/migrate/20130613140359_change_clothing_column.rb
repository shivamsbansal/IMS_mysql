class ChangeClothingColumn < ActiveRecord::Migration
 	def change
 		rename_column :clothings, :type, :clothCategory
 	end
end
