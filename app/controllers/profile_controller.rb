class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_signup_complete, only: [:index, :new, :create, :update, :destroy]
  before_action :set_user, only:[:index, :show, :edit, :update, :finish_signup]
  before_action :make_payment_services, only: [:index, :finish_signup, :show]

  def index
  end

  def show
    respond_to do |format|
      format.html do
        @user = User.find params[:id]
      end
      format.partial do
      	@user = current_user
      	render :partial => 'team/detailed_user.html', :locals => { :user => User.find(params[:id])}
      end
    end
  end

  def update
    if request.patch? && params[:user]

      if @user.update(user_params)
        redirect_to users_path, notice: 'Профиль обновлен.'
      else
        @show_errors = true
        render "edit"
      end
    end
  end
  def finish_signup
    # authorize! :update, @user
    if request.patch? && params[:user] #&& params[:user][:email]
      unless @user.email.match @user.TEMP_EMAIL_REGEX then
        redirect_to "/404.html"
        return
      end
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to users_path, notice: 'Профиль обновлен.'
      else
        @show_errors = true
      end
    end
  end

  def change_status
    flash[:notice] = "Статус успешно изменен!"
    # TODO: you know what do to here)
    redirect_to users_path
  end
  protected

  def user_params
    params.require(:user).permit(:email, :name, :last_name, :phone, :skype, :birthday, :sex, :country, :city, :about, :avatar, :vk, :fb, :ok, :youtube)
  end

  def set_user
    if params[:id].nil? then
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end
end
