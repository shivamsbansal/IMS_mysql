class Category < ActiveRecord::Base
	has_many :items, dependent: :restrict
	attr_accessible :nameCategory
	accepts_nested_attributes_for :items
	validates :nameCategory, presence: true, length: { maximum: 30 }
end
