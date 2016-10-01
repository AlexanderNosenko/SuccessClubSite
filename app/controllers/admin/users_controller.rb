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

  def changeparent
    @user = User.find(params[:id])
    @user.parent = User.find(params[:parent_id])
    if @user.save
      render plain: "User parent changed"
    else
      render plain: "Error while changing user parent"
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

  def parse
    data = params[:data]
    result = User.select(:id, :name, :last_name).where("name REGEXP('^#{data}') OR last_name REGEXP('^#{data}')").limit 10
    logger.debug result.to_a
    render json: result
  end
end
