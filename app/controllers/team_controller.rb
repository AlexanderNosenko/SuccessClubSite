class TeamController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = User.descendants.search(params[:search]).paginate(:per_page => 15, :page => params[:page])

    respond_to do |format|
      format.html { render :index }
      format.js { render :partial => 'user_list', :locals => { :team => @team} }
      # format.js { render json: params[:search] }
    end
  end
end
