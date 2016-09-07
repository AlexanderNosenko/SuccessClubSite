class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_signup_complete, only: [:index]
  before_action :make_payment_services, only: [:index]

  def index
    @users = User.count + 999
    @users_today = User.where('created_at > ?', 1.day.ago).count
    @descendants_today = current_user.descendants.where('created_at > ?', 1.day.ago).count
  end
end
