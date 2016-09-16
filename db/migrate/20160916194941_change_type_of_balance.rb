class ChangeTypeOfBalance < ActiveRecord::Migration
  class Wallet < ActiveRecord::Base
  end

  def change
    remove_column :wallets, :main_balance, :decimal
    remove_column :wallets, :bonus_balance, :decimal
    add_column :wallets, :main_balance, :float, default: 0
    add_column :wallets, :bonus_balance, :float, default: 0
  end
end
