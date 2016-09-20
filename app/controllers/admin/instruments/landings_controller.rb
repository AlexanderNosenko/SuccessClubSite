class Admin::Instruments::LandingsController < Admin::AdminController
  before_action :define_landing, only: [:show, :buy]
  before_action :authenticate_user!, only: [:buy]
  # I'm sure we haven't have to do this
  # before_action :make_payment_services
  # What about this one?
  require "will_paginate/array"
  def index
    @landings = Landing.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end

  def show
    respond_to do |format|
      format.html do
        render 'instruments/landings/detailed_landing.html'
      end
      format.partial do
        render :partial => 'instruments/landings/detailed_landing.html', :locals => { :user => User.find(params[:id])}
      end
    end
  end
  # def buy
  #   @user = current_user
  #   @wallet = @user.wallet
  #   @price = @landing.price.to_f
  #   # Need to correct this
  #   if @wallet.main_balance < @price
  #     render plain: "Not enough money"
  #   else
  #     @wallet.main_balance -= 10
  #     link = UserLanding.new
  #     keys = [:video_link, :has_vk, :has_ok, :has_fb, :has_youtube]
  #     parameters = params.slice(*keys)
      
  #     link.user_id = @user.id
  #     link.landing_id = @landing.id
  #     link.activated_at = Time.now
  #     link.reactivate_at = link.activated_at + 30.days
  #     # Need to generate form for this one
  #     link.update_attributes(**parameters)

  #     if link.save and @wallet.save
  #       render plain: 'Landing is linked successfully'
  #     else
  #       render plain: 'Something went wrong'
  #     end
  #   end
  # end

  private
  def define_landing
    @landing = Landing.find(params[:id])
  end
end
