class Item < ActiveRecord::Base
	belongs_to :itemCategory, :polymorphic =>true
	belongs_to :vendor, validate: true
	has_many :stocks, dependent: :restrict

	attr_accessible :codeItem, :nameItem, :lifeCycle, :leadTime, :itemCategory_id, :itemCategory_type, :vendor_id, :minimumStock, :cost, :assetType

	validate :ensure_vendor_exist
	
	validates :codeItem, presence: true, length: { maximum: 10 }, uniqueness: true
	validates :nameItem, presence: true, length: { maximum: 50 }, uniqueness: true
	validates :cost , presence:true ,numericality: true
	validates :lifeCycle, presence: true, numericality: true
	validates :leadTime, presence: true, numericality: true
	validates :minimumStock, presence: true, numericality: true
	validates :assetType, presence: true, length: { maximum: 15 }

	
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
