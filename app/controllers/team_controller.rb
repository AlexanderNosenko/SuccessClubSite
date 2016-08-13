class TeamController < ApplicationController
  before_action :authenticate_user!

  def index
  	@team = User.search(params[:search]).paginate(:per_page => 1, :page => params[:page])
  end
end
