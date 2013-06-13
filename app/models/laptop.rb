class Laptop < ActiveRecord::Base
	has_many :items, :as => :itemCategory, dependent: :restrict

	accepts_nested_attributes_for :items
	attr_accessible :brand, :model, :cpuSpeed, :ram

	validates :brand, presence: true
	validates :model, presence: true
	validates :cpuSpeed, presence: true, numericality: true
	validates :ram , presence: true, numericality: true
end
