class ClothingsController < ApplicationController

	def new
		@clothing = Clothing.new
	end

	def index
	end
end
