class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :capture_referal, :user_id
  private
  def capture_referal
    session[:p] = params[:p] if params[:p]
  end
  def user_id
    session[:id] = params[:id] if params[:id]
  end
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :last_name, :phone, :skype, :birthday, :sex, :country, :city, :about, :role, :email, :password, :password_confirmation, :remember_me, :referral_code, :avatar, :avatar_cache) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :last_name, :phone, :skype, :birthday, :sex, :county, :city, :about, :role, :email, :password, :password_confirmation, :current_password, :referral_code, :avatar, :avatar_cache, :remove_avatar) }
  end
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
end
