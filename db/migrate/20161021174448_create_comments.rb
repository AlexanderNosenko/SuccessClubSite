class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :rate, default: 5
      t.integer :user_id
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps null: false
    end

    add_index :comments, [:commentable_type, :commentable_id]
  end
end
