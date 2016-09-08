class TeamController < ApplicationController
  before_action :authenticate_user!
  before_action :make_payment_services, only:[:index]
  require 'will_paginate/array'

  def index
    respond_to do |format|
      format.html do
        @user = current_user
      	@team = current_user.descendants.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
        @ancestors = current_user.ancestors.reverse.paginate(:per_page => 15, :page => params[:page])
      	render :index
      end
      format.js do
      	@team = current_user.search_descendants(params[:search])
      	render :partial => 'user_list', :locals => { :team => @team}# unless @team.nil?
      end
    end
  end

end
