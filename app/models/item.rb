class Item < ActiveRecord::Base
	belongs_to :itemCategory, :polymorphic =>true
	belongs_to :vendor, validate: true

	attr_accessible :codeItem, :nameItem

	validate :ensure_vendor_exist
	
	validates :codeItem, presence: true
	validates :nameItem, presence: true
	validates	:itemCategory_id, presence: true
	validates :itemCategory_type, presence: true
	
	private

		def ensure_vendor_exist
			if Vendor.find(self.vendor_id).nil?
				errors.add('Vendor')
				false
			else
				true
			end
		end
end
