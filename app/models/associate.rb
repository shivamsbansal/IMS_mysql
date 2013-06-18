class Associate < ActiveRecord::Base
  belongs_to :station
  has_many :issued_items, dependent: :destroy

  accepts_nested_attributes_for :issued_items
  before_save { self.email = email.downcase }
  attr_accessible :name, :email, :dateOfJoining, :station_id 

  validate :ensure_station_exist
  validates :name , presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :dateOfJoining, presence: true
  validates :station_id, presence: true	

  private

   def ensure_station_exist
      if Station.find(self.station_id).nil?
        errors.add(:station_id, 'Station does not exist')
        false
      else
        true
      end
    end
end
