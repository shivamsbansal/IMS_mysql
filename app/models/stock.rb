class Stock < ActiveRecord::Base
	belongs_to :station, :item
	has_many :assets, dependent: :destroy
	has_many :transits, dependent: :restrict

	accepts_nested_attributes_for :assets, :transits

  attr_accessible :item_id, :station_id, :poId, :poDate, :invoiceNo, :invoiceDate, :warrantyPeriod, :initialStock, :presentStock, :issuedReason 

  validate :ensure_station_exist
  validate :ensure_item_exist
  validates :item_id, presence: true
  validates :station_id, presence: true
  validates :poId, presence: true
  validates :poDate, presence: true
  validates :invoiceNo, presence: true
  validates :invoiceDate, presence: true
  validates :warrantyPeriod, presence: true
  validates :initialStock, presence: true
  validates :presentStock, presence: true
  validates :issuedReason, presence: true

  private

  	def ensure_station_exist
  		if Station.find(self.station_id).nil?
        errors.add(:station_id, 'Station does not exist')
        false
      else
        true
      end
  	end

  	def ensure_item_exist
  		if Item.find(self.item_id).nil?
        errors.add(:item_id, 'Item does not exist')
        false
      else
        true
      end
  	end

end
