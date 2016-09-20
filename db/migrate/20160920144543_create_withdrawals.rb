class CreateWithdrawals < ActiveRecord::Migration
  def change
    create_table :withdrawals do |t|
      t.integer :user_id
      t.float :amount
	  t.string :method
      t.boolean :status

      t.timestamps null: false
    end
  end
end
