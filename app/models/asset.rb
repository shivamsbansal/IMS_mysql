class Asset < ActiveRecord::Base
	belongs_to :stock
	has_one :issued_item, dependent: :destroy
  has_one :associate, through: :issued_item
	accepts_nested_attributes_for :issued_item
  attr_accessible :assetSrNo, :stock_id, :issued

  validates :assetSrNo, presence: true
  validates :stock_id, presence: true
  validate :ensure_stock_exists
 

  private
  	def ensure_stock_exists
  		if Stock.find(self.stock_id).nil?
				errors.add('Stock')
				false
			else
				true
			end
  	end
end
