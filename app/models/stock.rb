class Stock < ActiveRecord::Base
	belongs_to :station
  belongs_to :item
	has_many :assets, dependent: :destroy
	has_many :transfers, dependent: :restrict

	accepts_nested_attributes_for :assets, :transfers

  attr_accessible :item_id, :station_id, :poId, :poDate, :invoiceNo, :invoiceDate, :warrantyPeriod, :initialStock, :presentStock, :issuedReason, :inTransit

  validate :ensure_station_exist
  validate :ensure_item_exist
  validates :item_id, presence: true
  validates :station_id, presence: true
  validates :poId, presence: true
  validates :poDate, presence: {:message => 'is Bank/invalid'}
  validates :invoiceNo, presence: true
  validates :invoiceDate, presence: {:message => 'is Bank/invalid'}
  validates :warrantyPeriod, presence: true
  validates :initialStock, presence: true, numericality: true
  validates :presentStock, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :issuedReason, presence: true
  validates :inTransit, :inclusion => {:in => [true, false]}
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
