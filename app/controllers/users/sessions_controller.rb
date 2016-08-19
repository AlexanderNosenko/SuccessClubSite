class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  layout 'empty', only: [:new, :create, :destroy]
  prepend_before_action :check_captcha, only: [:create]
  #GET /sign_in
  def new
    super
  end

  #POST /sign_in
  def create
    super
  end

  #DELETE /sign_out
  def destroy
    super
  end

  protected

  #If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
  private
  def check_captcha
    #redirect_to(:new_user_session) unless verify_recaptcha
  end
end
