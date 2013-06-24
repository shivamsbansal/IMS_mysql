class Asset < ActiveRecord::Base
	belongs_to :stock
	has_many :issued_items
  has_many :associates, through: :issued_items
	accepts_nested_attributes_for :issued_items
  attr_accessible :assetSrNo, :stock_id, :issued

  validates :assetSrNo, presence: true
  validates :stock_id, presence: true
  validates :issued, presence: true
  validate :ensure_stock_exists
  validate :ensure_present_stock_is_correct

  private

    def ensure_present_stock_is_correct
      if Stock.find(self.stock_id).presentStock - 1 == Stock.assets
        true
      else
        errors.add('Stock')
        false
      end
    end

  	def ensure_stock_exists
  		if Stock.find(self.stock_id).nil?
				errors.add('Stock')
				false
			else
				true
			end
  	end
end
