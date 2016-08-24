class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.decimal :main_balance
      t.decimal :bonus_balance

      t.timestamps null: false
    end
  end
end
