class LandingController < ApplicationController
  layout 'landing_layout', only: [:index]

  def index
    if user_signed_in?
      redirect_to :controller => 'home', :action => 'index'
    end
  end

end