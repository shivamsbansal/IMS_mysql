class Transfers < ActiveRecord::Base
	 attr_accessible :from, :to, :dateOfDispatch, :dateOfReceipt
	 belongs_to :station, foreign_key: "from"
	 belongs_to :station, foreign_key: "to"
	 belongs_to :stock

	 validates :from, presence: true
	 validates :to, presence: true
	 validates :dateOfDispatch, presence: true
	 
end
