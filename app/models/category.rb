class Category < ActiveRecord::Base
	attr_accessible :nameCategory

	validates :nameCategory, presence: true, length: { maximum: 30 }
end
