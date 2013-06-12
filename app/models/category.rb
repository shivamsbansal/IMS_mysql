class Category < ActiveRecord::Base
	attr_accessible :nameCategory

	validates :nameCategory, presence: true
end
