module StationsHelper

	def user_access_stations(user)
		if user[:level_type]!= nil 
			if user.admin?
				@stations = Station.all
				@name = "Central Team" 
			elsif Region.find(user.level_id).nameRegion=="India"
				@stations=Station.where("nameStation NOT LIKE 'ATS-WTC'")
				@name = "India"
			else
				@stations=[]
				if user.level_type == "Region" 
					@region = Region.find(user.level_id)
					@territories = @region.territories.all
					@territories.each do |t|
						@stations =@stations + t.stations
					end
					@name = @region.nameRegion
				elsif user[:level_type] == "Territory"
					@stations = Territory.find(user.level_id).stations
					@name=Territory.find(user.level_id).nameTerritory
				else
					@stations = Station.find(user.level_id)
					@name = Station.find(user).nameStation
				end
			end
			{stations: @stations, name: @name}
		else
			nil
		end		
	end
	
end
