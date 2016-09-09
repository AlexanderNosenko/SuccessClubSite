class CreateLandings < ActiveRecord::Migration
  def change
    create_table :landings do |t|
      t.string :name
      t.string :logo
      t.integer :price

      t.timestamps null: false
    end
    add_index :landings, :name, unique: true
  end
end
