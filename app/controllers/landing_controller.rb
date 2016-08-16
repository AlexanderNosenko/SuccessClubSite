class LandingController < ApplicationController
  layout 'landing_layout', only: [:index]

  def index
    if user_signed_in?
      redirect_to :controller => 'home', :action => 'index'
    else
      redirect_to new_user_session_path
    end
  end

end
