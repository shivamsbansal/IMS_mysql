class Station < ActiveRecord::Base
	has_many :users, as: :level, dependent: :nullify
	belongs_to :territory, validate: true

	accepts_nested_attributes_for :users
	attr_accessible :nameStation, :territory_id

	validate :ensure_territory_exist

	validates :nameStation, presence: true, length: {maximum: 30}, uniqueness: true
	validates :territory_id, presence: true

	private

		def ensure_territory_exist
			if Territory.find(self.territory_id).nil?
				errors.add('Territory')
				false
			else
				true
			end
		end

end
