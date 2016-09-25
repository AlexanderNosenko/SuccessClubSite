class TeamController < ApplicationController
  before_action :authenticate_user!
  before_action :make_payment_services, only:[:index]
  require 'will_paginate/array'

  def index
    respond_to do |format|
      format.html do
        @user = current_user
      	@team = @user.descendants.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
        @ancestors = @user.ancestors.reverse.paginate(:per_page => 15, :page => params[:page])
      	render :index
      end
      format.js do
        # if params[:type] == 'partners'
        # TODO Need to fix search trought parents, not partners
        if true
      	  @team = current_user.search_descendants(params[:search])
        else
          @team = current_user.search_ancestors(params[:search])
        end
        render partial: 'user', collection: @team # unless @team.nil?
      end
    end
  end

end
