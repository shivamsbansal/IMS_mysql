module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Inventory Management System"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def timePeriod(name, default, disable = false)
  	select_tag(name.to_sym, options_for_select((1..30).each {|n| ["#{n}",n]}, default ), disabled: disable)
  end

  def timePeriodType(name, default, disable = false)
   	select_tag("#{name}Type".to_sym, options_for_select(['day','month','year'].each {|n| [n,n]}, default ), disabled: disable) 
  end

  def toSensibleTime(seconds)
  	years, s = seconds.divmod(31557600)
  	months, s = s.divmod(30*86400)
  	days, s = s.divmod(86400)
  	{years: years, months: months, days: days} 
  end

  def toSensibleWords(hash)
    string = ''
    if hash[:years] != 0
      string =  "#{string} #{hash[:years]} years"
    end
    if hash[:months] != 0
      string = "#{string} #{hash[:months]} months"
    end
    if hash[:days] != 0
      string = "#{string} #{hash[:days]} days"
    end
    string
  end

  def toInsensibleTime(seconds)
    if seconds != nil
      if (seconds % 31557600) == 0
        result = {value: (seconds/31557600), period: "year"}
      elsif (seconds % 2592000) == 0
        result = {value: (seconds/2592000), period: "month"}
      else
        result = {value: (seconds/86400), period: "day"}
      end
    else
      result = {value: 1, period: "day"}
    end
  end

  def atleast_one_station
    if user_access_stations(current_user) == nil
      redirect_to current_user, notice: "Currently no station assigned"
    end
  end
end