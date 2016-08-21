class CreatePartnerLinks < ActiveRecord::Migration
  def change
    create_table :partner_links do |t|
      t.references :user, index: true, foreign_key: true
      t.string :link
      t.string :use_for

      t.timestamps null: false
    end
  end
end
