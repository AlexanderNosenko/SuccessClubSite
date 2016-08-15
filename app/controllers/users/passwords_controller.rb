class Users::PasswordsController < Devise::PasswordsController
  before_filter :authenticate_user!
  prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

  layout 'empty', only: [:new, :create, :edit, :update]
  skip_before_filter :require_no_authentication#, only: [:new, :create, :edit, :update]
  # GET /resource/password/new
  def new
    super
  end

  private
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        respond_with_navigational(resource) { render :new }
      end
    end
  # POST /resource/password
  # def create
  #   self.user = User.send_reset_password_instructions(resource_params)
  #   yield user if block_given?
  #
  #   if successfully_sent?(user)
  #     respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
  #   else
  #     respond_with(resource)
  #   end
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
