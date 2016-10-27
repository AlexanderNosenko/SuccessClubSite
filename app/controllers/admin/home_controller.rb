class Admin::HomeController < Admin::AdminController
  def index
    @users_money = Wallet.where.not(user_id: [2, 56, 61, 85, 1136]).sum(:main_balance)
  end
end
