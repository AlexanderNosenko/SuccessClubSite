class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  layout 'empty', only: [:new, :create, :destroy]

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
end
