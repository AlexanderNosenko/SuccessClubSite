class Instruments::LandingsController < ApplicationController
  def index
    @landings = Landing.all
  end
  def activate
    # DANIIL, your time has come
    flash[:notice] = "Landing Page успешно активирован"
    redirect_to action: :index
  end
end
