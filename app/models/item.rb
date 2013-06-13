class Item < ActiveRecord::Base
	belongs_to :itemCategory, :polymorphic =>true
	belongs_to :vendor, validate: true

	attr_accessible :codeItem, :nameItem, :lifeCycle, :leadTime, :itemCategory_id, :itemCategory_type, :vendor_id, :minimumStock, :cost

	validate :ensure_vendor_exist
	
	validates :codeItem, presence: true
	validates :nameItem, presence: true
	validates :cost , presence:true ,numericality: true
	validates :lifeCycle, presence: true, numericality: true
	validates :leadTime, presence: true, numericality: true
	validates :vendor_id, presence: true
	validates :minimumStock, presence: true, numericality: true

	
	private

		def ensure_vendor_exist
			if self.vendor_id.nil?
				true
			elsif Vendor.find(self.vendor_id).nil?
				errors.add('Vendor')
				false
			else
				true
			end
		end
end
