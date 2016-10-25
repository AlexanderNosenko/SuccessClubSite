module UserHelper

  def land_activated_at landing_id
  	current_user.user_landings.find_by_landing_id(landing_id).activated_at.strftime("%d/%m/%y")
  end

  def land_reactivate_at landing_id
  	current_user.user_landings.find_by_landing_id(landing_id).reactivate_at.strftime("%d/%m/%y")
  end

  def landing_outer_path landing_path
    "http://promo.improf.club/#{landing_path}/#{current_user.id}"
  end
end
