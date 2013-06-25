class IssuedConsumable < ActiveRecord::Base
  belongs_to :associate
 	belongs_to :stock

 	attr_accessible :associate_id, :stock_id, :dateOfIssue
 
 	validates :associate_id, presence: true
 	validates :stock_id, presence: true
 	validates :dateOfIssue, presence: true
	validate :ensure_associate_exist
	validate :ensure_stock_exist

 	private

	 	def ensure_associate_exist
	    if Associate.find(self.associate_id).nil?
	      errors.add(:associate_id, 'Associate does not exist')
	      false
	    else
	      true
	    end
	  end

	  def ensure_stock_exist
	    if Asset.find(self.stock_id).nil?
	      errors.add(:stock_id, 'Stock does not exist')
	      false
	    else
	      true
	    end
	  end
end
