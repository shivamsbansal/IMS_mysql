class Laptop < ActiveRecord::Base
	has_many :items, :as => :itemCategory, dependent: :restrict

end
