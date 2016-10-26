class Admin::Instruments::LandingsController < Admin::AdminController
  before_action :define_landing, only: [:show, :buy]
  before_action :authenticate_user!, only: [:buy]
  require "will_paginate/array"
  def index
    @landings = Landing.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end

  def show
    respond_to do |format|
      format.html do
        render 'instruments/landings/detailed_landing.html'
      end
      format.partial do
        render :partial => 'instruments/landings/detailed_landing.html', :locals => { :user => User.find(params[:id])}
      end
    end
  end
  
  private
  def define_landing
    @landing = Landing.find(params[:id])
  end
end
