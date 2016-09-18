class Admin::Instruments::LandingsController < Admin::AdminController
  before_action :define_landing, only: [:show]
  def index
    @landings = Landing.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end

  def show
    render json: @landing
  end

  private
  def define_landing
    @landing = Landing.find(params[:id])
  end
end
