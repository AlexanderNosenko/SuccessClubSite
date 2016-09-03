class AddFieldsToPayments < ActiveRecord::Migration
  class Payment < ActiveRecord::Base
  end

  def change
    remove_column :payments, :user_id
    add_column :payments, :user_id, :integer
  end
end
