class AddOtherFieldsToPayments < ActiveRecord::Migration
  class Payment < ActiveRecord::Base
  end

  def change
    remove_column :payments, :updated_at, :datetime
    remove_column :payments, :user_id, :integer
    add_column :payments, :from_user_id, :integer
	add_column :payments, :to_user_id, :integer
	add_column :payments, :from, :string, limit: 10 # 'user, system'
	add_column :payments, :to, :string, limit: 10 # "user, system"
	add_column :payments, :method, :string, limit: 20 # 'perfect, nix, adv, liq...'
	remove_reference :payments, :users, column: :user_id, primary_key: :id, index: true
  end
end
