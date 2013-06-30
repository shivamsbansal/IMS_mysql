class Stock < ActiveRecord::Base
	belongs_to :station
  belongs_to :item
	has_many :assets, dependent: :destroy
	has_many :transfers, dependent: :restrict
  has_many :issued_consumables, dependent: :destroy

	accepts_nested_attributes_for :assets, :transfers, :issued_consumables

  attr_accessible :item_id, :station_id, :poId, :poDate, :invoiceNo, :invoiceDate, :warrantyPeriod, :initialStock, :presentStock, :inTransit, :comments

  validate :ensure_station_exist
  validate :ensure_item_exist
  validates :item_id, presence: true
  validates :station_id, presence: true
  validates :poId, presence: true, length: {maximum: 20}
  validates :poDate, presence: {:message => 'is blank/invalid'}
  validates :invoiceNo, presence: true, length: {maximum: 20}
  validates :invoiceDate, presence: {:message => 'is blank/invalid'}
  validates :warrantyPeriod, presence: true
  validates :initialStock, presence: true, numericality: true
  validates :presentStock, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
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
