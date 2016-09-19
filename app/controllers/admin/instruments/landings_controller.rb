class Admin::Instruments::LandingsController < Admin::AdminController
  before_action :define_landing, only: [:show, :buy]
  before_action :authenticate_user!, only: [:buy]
  # I'm sure we haven't have to do this
  before_action :make_payment_services
  # What about this one?
  require "will_paginate/array"
  def index
    @landings = Landing.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end

  def show
    #render json: @landing
  end
  
  def buy
    @user = current_user
    @wallet = @user.wallet
    @price = @landing.price.to_f
    # Need to correct this
    if @wallet.main_balance < @price
      render plain: "Not enough money"
    else
      @wallet.main_balance -= 10
      link = UserLanding.new
      keys = [:video_link, :has_vk, :has_ok, :has_fb, :has_youtube]
      parameters = params.slice(*keys)
        user_id: @user.id, landing_id: @landing.id, **params
      )
      
  end

  private
  def define_landing
    @landing = Landing.find(params[:id])
  end
end


__END__
  def index
    @users = User.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @descendants = @user.descendants
    @parent = @user.parent
  end

  def changerole
    @user = User.find(params[:id])
    @user.role = Role.find(params[:role_id])
    if @user.save
      render plain: "User role changed"
    else
      render plain: "Error while changing user role"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render plain:'User destroyed'
    else
      render plain:'User not deleted', status: 406
    end
  end
end
