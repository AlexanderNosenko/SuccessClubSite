class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :logo
      t.string :description
      t.string :video_link
      t.string :instruction
      t.datetime :opened_at
      t.integer :min_investitions
      t.string :status

      t.timestamps null: false
    end
  end
end
