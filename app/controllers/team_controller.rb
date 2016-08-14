class TeamController < ApplicationController
  before_action :authenticate_user!
  require 'will_paginate/array'

  def index
    @team = User.descendants.paginate(:per_page => 15, :page => params[:page])

    respond_to do |format|
      format.html { render :index }
      format.js { render :partial => 'user_list', :locals => { :team => @team} }
      # format.js { render json: params[:search] }
    end
  end
end
