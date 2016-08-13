class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_signup_complete, only: [:new, :create, :update, :destroy]
  before_action :set_user, only:[:show, :finish_signup]

  def index
  end

  def show
  end

  def finish_signup
    # authorize! :update, @user
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to profile_path, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :name, :last_name, :phone, :skype, :birthday, :sex, :country, :city, :about)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
