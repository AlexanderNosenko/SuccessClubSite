class Admin::UsersController < Admin::AdminController
  def index
    @users = User.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end
  def show
    @user = User.find(params[:id])
    @descendants = @user.descendants
    @parent = @user.parent
  end
end
