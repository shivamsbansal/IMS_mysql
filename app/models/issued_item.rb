class IssuedItem < ActiveRecord::Base
   belongs_to :associate, :asset

   attr_accessible :asset_id, :associate_id, :dateOfIssue, :quantity
   
   validates :associate_id, presence: true
   validates :asset_id, presence: true
   validates :quantity, presence: true 
   validates :dateOfIssue, presence: true
   validate :ensure_associate_exist
   validate :ensure_asset_exist

   private

   	def ensure_level_exist
      if Associate.find(self.associate_id).nil?
        errors.add(:associate_id, 'Associate does not exist')
        false
      else
        true
      end
    end

    def ensure_level_exist
      if Asset.find(self.asset_id).nil?
        errors.add(:asset_id, 'Asset does not exist')
        false
      else
        true
      end
    end

end
