class Admin::Instruments::LandingsController < Admin::AdminController
  def index
    Landing.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end
end
