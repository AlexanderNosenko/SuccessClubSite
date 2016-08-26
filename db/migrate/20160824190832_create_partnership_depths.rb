class CreatePartnershipDepths < ActiveRecord::Migration
  def change
    create_table :partnership_depths do |t|
      t.integer :percent

      t.timestamps null: false
    end
  end
end
