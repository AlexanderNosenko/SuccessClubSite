class AddAccountToWithdrawal < ActiveRecord::Migration
  def change

  	add_column :withdrawals, :user_account, :string   # 'user, system'

  end
end
