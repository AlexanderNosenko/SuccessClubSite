class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_signup_complete, only: [:index]
  before_action :make_payment_services, only: [:index]

  def index
    @descendants = current_user.descendants
    @descendants_today = @descendants.map { |u|
      u if u.created_at.today?
    }.compact.count
  end
end
