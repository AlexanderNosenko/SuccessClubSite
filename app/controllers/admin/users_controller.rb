class Admin::UsersController < Admin::AdminController

  before_action :set_user, only: [:show, :changerole, :givebonus, :destroy]

  def index
    @users = User.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end

  def show
    @descendants = @user.descendants
    @parent = @user.parent
  end

  def changerole
    @user.role = Role.find(params[:role_id])
    if @user.save
      render plain: "User role changed"
    else
      render plain: "Error while changing user role"
    end
  end

  def givebonus
    @user.wallet.bonus_balance += params[:amount].to_f
    if @user.wallet.save
      render plain: "Bonus balance updated"
    else
      render plain: "Error while updating bonus balance"
    end
  end

  def destroy
    if @user.destroy
      render plain:'User destroyed'
    else
      render plain:'User not deleted', status: 406
    end
  end

  private
  def set_user
    @user = User.find params[:id]
  end
end
