class TeamController < ApplicationController
  before_action :authenticate_user!
  require 'will_paginate/array'

  def index
    respond_to do |format|
      format.html do
        @user = current_user
      	@team = @user.children.order(created_at: :desc).paginate(per_page: 15, page: params[:page])
        @ancestors = @user.ancestors.reverse.paginate(per_page: 15, page: params[:page])
        @foreign = false
      	render :index
      end
      format.js do
        # if params[:type] == 'partners'
        # TODO Need to fix search trought parents, not partners
        @user = (true) ? current_user : User.find(params[:id])
        if true
      	  @team = current_user.search_descendants(params[:search])
        else
          @team = current_user.search_ancestors(params[:search])
        end
        render partial: 'user', collection: @team # unless @team.nil?
      end
    end
  end

  def user_team
    respond_to do |format|
      format.html do
        @user = User.find(params[:id])
        if @user == current_user
          redirect_to team_path
          return
        end
        if @user.nil? or !current_user.descendant_ids.include?(@user.id)
          flash[:notice] = 'Вы не можете просматривать эту команду'
          redirect_to team_path
          return
        end
        @team = @user.children.order(created_at: :desc).paginate(per_page: 15, page: params[:page])
        @ancestors = @user.ancestors.select { |a| a.depth >= current_user.depth }.reverse
        @foreign = true
        render :index
      end
    end
  end
end
