class TeamController < ApplicationController
  before_action :authenticate_user!

  def index
  	@products = Product.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
  end
end
