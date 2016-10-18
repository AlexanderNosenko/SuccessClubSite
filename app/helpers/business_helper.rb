module BusinessHelper
  def active_class type
    params[:type] == type ? "active" : ""
  end

  def opened_ago business
  	distance_of_time_in_words Time.now, business.opened_at
  end

  def created_ago business
  	distance_of_time_in_words Time.now, business.created_at  	
  end
end
