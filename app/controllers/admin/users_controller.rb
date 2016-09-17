class Admin::UsersController < Admin::AdminController

  def index
    @users = User.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @descendants = @user.descendants
    @parent = @user.parent
  end

  def changerole
    @user = User.find(params[:id])
    @user.role = Role.find(params[:role_id])
    if @user.save
      render plain: "User role changed"
    else
      render plain: "Error while changing user role"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render plain:'User destroyed'
    else
      render plain:'User not deleted', status: 406
    end
  end
end
