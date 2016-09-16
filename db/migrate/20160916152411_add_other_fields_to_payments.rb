class AddOtherFieldsToPayments < ActiveRecord::Migration
  class Payment < ActiveRecord::Base
  end

  def change
    remove_column :payments, :updated_at
    add_column :payments, :from, :string
    add_column :payments, :to, :string
    # add_reference :payments, :users, column: :user_id, primary_key: :id, index: true
	remove_reference :payments, :users, column: :user_id, primary_key: :id, index: true
  end
end
