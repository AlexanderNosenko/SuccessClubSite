class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :user_id
      t.float :amount
      
      t.timestamps null: false
    end
    add_reference :payments, :users, column: :user_id, primary_key: :id, index: true
    # add_foreign_key :payments, :users, column: :user_id, primary_key: :id

  end
end
