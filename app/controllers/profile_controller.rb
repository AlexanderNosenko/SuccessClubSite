class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_signup_complete, only: [:new, :create, :update, :destroy]


  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def finish_signup
  # authorize! :update, @user
  if request.patch? && params[:user] #&& params[:user][:email]
    if @user.update(user_params)
      @user.skip_reconfirmation!
      sign_in(@user, :bypass => true)
      redirect_to @user, notice: 'Your profile was successfully updated.'
    else
      @show_errors = true
    end
  end
end
end
