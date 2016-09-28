class Instruments::LandingsController < ApplicationController
  before_action :define_landing, only: [:show, :activate]
  before_action :authenticate_user!, only: [:index, :activate]
  # OPTIMIZE I'm sure we haven't have to do this
  before_action :make_payment_services
  # What about this one?
  require "will_paginate/array"
  def index
    @for_free = current_user.free_land_number > 0
    @landings = Landing.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end

  def show
    respond_to do |format|
      # format.html do
      #   render 'instruments/landings/_detailed_landing.html'
      # end
      format.partial do
        render :partial => 'instruments/landings/detailed_landing.html', :locals => { :user => User.find(params[:id])}
      end
    end
  end

  def activate #  empty
    @user = current_user
    @wallet = @user.wallet
    @price = @landing.price.to_f
    empty = current_user.free_land_number > 0

    unless empty or @user.enough? @price
      flash[:notice] = "Недостаточно средств для активации"
      redirect_to action: :index
      return
    end

    # @wallet.main_balance -= @price
    if UserLanding.find_by(user_id: @user.id, landing_id: @landing.id)
    	flash[:notice] = 'Этот landing page уже активирован'
      redirect_to action: :index
      return
    end

	  link = UserLanding.new
	  keys = [:video_link, :has_vk, :has_ok, :has_fb, :has_youtube]
	  # OPTIMIZE parameters = params.slice(*keys)
	  parameters = {video_link: '', has_fb: true, has_ok: true, has_vk: true, has_youtube: true}

	  link.user_id = @user.id
	  link.landing_id = @landing.id
	  link.activated_at = Time.now
    if empty
      link.reactivate_at = link.activated_at + 2.years
    else
	    link.reactivate_at = link.activated_at + 30.days
    end
	  # TODO Need to generate form for this one
	  link.update_attributes(**parameters)

    unless empty
      unless @user.take_money @price
        flash[:notice] = 'Что-то пошло не так'
        redirect_to action: :index
        return
      end
    end
    unless link.save
      flash[:notice] = 'Что-то пошло не так'
      @user.give_money @price
      redirect_to action: :index
      return
    end

    flash[:notice] = 'Landing page успешно активирован!'
    redirect_to action: :index
  end

  private
  def define_landing
    @landing = Landing.find(params[:id])
    # TODO Check for existance?
  end
end
