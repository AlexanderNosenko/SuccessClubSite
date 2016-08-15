class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_signup_complete, only: [:index]
  
  def index
  end
end
