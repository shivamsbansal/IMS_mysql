class Territory < ActiveRecord::Base
	has_many :stations, dependent: :restrict
	has_many :users, as: :level, dependent: :nullify

	accepts_nested_attributes_for :stations, :users
	attr_accessible :nameTerritory, :region_id, :idTerritory

	belongs_to :region, validate: true

	validate :ensure_region_exist

	validates :nameTerritory, presence: true, length: {maximum: 30}, uniqueness: true
	validates :idTerritory, presence: true, length: {maximum: 6}, uniqueness: true
	validates :region_id, presence: true

	private

		def ensure_region_exist
			if Region.find(self.region_id).nil?
				errors.add('Region')
				false
			else
				true
			end
		end
end
