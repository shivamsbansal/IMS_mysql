class Vendor < ActiveRecord::Base
	has_many :items ,dependent: :nullify

	accepts_nested_attributes_for :items
	attr_accessible :nameVendor, :email, :phone, :itemCategory
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :nameVendor, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format:     { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :phone, presence: true, length: { is: 10 }, numericality: true
	validates :itemCategory, presence: true, length: {maximum: 30}
	validate :ensure_category_exist

	private

		def ensure_category_exist
			if Category.find_by_nameCategory(self.itemCategory).nil? && self.itemCategory != 'All'
				errors.add('Category')
				false
			else
				true
			end
		end
end
