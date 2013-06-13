class Clothing < ActiveRecord::Base
	has_many :items, :as => :itemCategory, dependent: :restrict

	accepts_nested_attributes_for :items
	attr_accessible :brand, :clothCategory, :size

	validates :brand, presence: true
	validates :clothCategory, presence: true
	validates :size, presence: true

end
