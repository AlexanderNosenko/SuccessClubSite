class Admin::HomeController < Admin::AdminController
  def index
    developers_ids = [2, 56, 61, 85, 1136]
    @users_money = Wallet.where.not(user_id: developers_ids).sum(:main_balance)
    @got = Payment.where.not(to_user_id: developers_ids).sum(:amount)
    @withdrawn = Withdrawal.where.not(id: developers_ids).where(status: true).sum(:amount)
    @we_have = @got - @users_money - @withdrawn
  end
end
