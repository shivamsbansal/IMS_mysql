class StationsController < ApplicationController
	before_filter :signed_in_user, only: [:new, :edit,    :index, :create, :update]
	before_filter :admin_user, only: [:new, :update, :edit, :create]

	def update
		@station = Station.find(params[:id])
		if @station.update_attributes(nameStation: params[:nameStation], territory_id: params[:territory_id])
	      flash[:success] = "Territory updated"
	      redirect_to stations_path
	    else
	      render 'edit'
	    end
	end

	def edit
		@station = Station.find(params[:id])
	end

	def new
		@station = Station.new
	end

	def index
		if current_user[:level_type]!= nil 
			if current_user.admin? || Region.find(current_user.level_id).nameRegion=="India"
				@stations=Station.all 
				@name = "India"
			else
				@stations=[]
				if current_user.level_type == "Region" 
					@region = Region.find(current_user.level_id)
					@territories = @region.territories.all
					@territories.each do |t|
						@stations =@stations + t.stations
					end
					@name = @region.nameRegion
				elsif current_user[:level_type] == "Territory"
					@stations = Territory.find(current_user.level_id).stations
					@name=Territory.find(current_user.level_id).nameTerritory
				else
					@stations = Station.find(current_user.level_id)
					@name = Station.find(current_user).nameStation
				end
			end
		else
			flash.now[:notice] = "No station assigned to you"
		end
	end

	def create
	  	@station = Station.new(nameStation: params[:nameStation], territory_id: params[:territory_id])
	  	if @station.save
	      flash[:success] = "Successfully added #{@station.nameStation}"
	      redirect_to stations_path
	    else
	    	render 'new'
	  	end
  	end

end
