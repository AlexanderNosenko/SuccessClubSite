class AddColumnToUserBusinesses < ActiveRecord::Migration
  def change

  	add_column :user_businesses, :block_reg, :boolean

  end
end
