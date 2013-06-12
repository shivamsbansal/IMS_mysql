class Vendor < ActiveRecord::Base
	has_many :items ,dependent: :nullify
	accepts_nested_attributes_for :items
	attr_accessible :nameVendor, :email, :phone
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :nameVendor, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format:     { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :phone, presence: true, length: { is: 10 }
end
