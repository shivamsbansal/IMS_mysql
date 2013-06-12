class LaptopsController < ApplicationController

	def new
		@laptop = Laptop.new
	end

	def index
	end
end
