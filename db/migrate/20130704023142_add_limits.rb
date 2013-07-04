class AddLimits < ActiveRecord::Migration
  def change
  	change_column :assets, :assetSrNo, :string,  :limit => 20
  	change_column :associates, :email, :string
  	change_column :categories, :nameCategory, :string, :limit => 30
  	change_column :items, :codeItem, :string, :limit => 10
  	change_column :items, :nameItem, :string, :limit => 50
  	change_column :items, :assetType, :string, :limit => 15
  	change_column :regions, :idRegion, :string, :limit => 10
  	change_column :regions, :nameRegion, :string, :limit => 30
  	change_column :stations, :nameStation, :string, :limit => 30
  	change_column :stocks, :invoiceNo, :string, :limit => 20
  	change_column :territories, :idTerritory, :string, :limit => 10
  	change_column :territories, :nameTerritory, :string, :limit => 30
  	change_column :users, :name, :string, :limit => 50
  	change_column :vendors, :nameVendor, :string, :limit => 50
  end
end
