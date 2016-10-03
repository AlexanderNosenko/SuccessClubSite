class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_signup_complete, only: [:index]
  before_action :make_payment_services, only: [:index]

  def index
    @users = User.count + 999
    @today = Time.now.beginning_of_day
    @users_today = User.where('created_at > ?', @today).count
    @descendants_today = current_user.children.where('created_at > ?', @today).count
  end
  def set_view_mode
  	session[:menu_bar_view_mode] = params['view_mode'];
  	render json: {'status' => 'ok'}.to_json
  end
end
