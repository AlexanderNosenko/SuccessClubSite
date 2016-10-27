class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
  layout 'empty', only: [:new, :create, :update, :destroy, :cancel]
  #prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.
skip_before_action :verify_authenticity_token, only: [:create]
  # GET /resource/sign_up
  def new
    @parent = User.find(session[:parent_id]) if session[:parent_id]
    super
  end

  # POST /resource
  def create
    if params[:from_landing]
      session[:parent_id] = params[:parent_id]
      session[:came_from] = Landing.find_by_short_path(params[:company_name]).business.name
    end
    super
  end

  # GET /resource/edit
   def edit
     return
     render :layout => "application"
     super
   end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
    def check_captcha
      redirect_to new_user_registration_path unless verify_recaptcha
    end
  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource_or_scope)
  #   session["user_return_to"] || root_path
  # end
end
