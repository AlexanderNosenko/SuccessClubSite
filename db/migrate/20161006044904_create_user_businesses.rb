class CreateUserBusinesses < ActiveRecord::Migration
  def change
    create_table :user_businesses do |t|
      t.integer :user_id
      t.integer :business_id
      t.integer :partner_link_id

      t.timestamps null: false
    end
  end
end
