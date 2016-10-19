module BusinessHelper
  def active_class type
    params[:type] == type ? "active" : ""
  end

  def opened_ago business
  	distance_of_time_in_words Time.now, business.opened_at || business.created_at
  end

  def created_ago business
  	distance_of_time_in_words Time.now, business.created_at
  end

  def get_stars number
    text = ""
    number.times do
      text += '<i class="fa fa-star fullstar"></i>'
    end
    (5 - number).times do
      text += '<i class="fa fa-star"></i>'
    end
    text.html_safe
  end
end
