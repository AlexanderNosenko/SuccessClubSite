class CreateUserLandings < ActiveRecord::Migration
  def change
    create_table :user_landings do |t|
      t.integer :user_id
      t.integer :landing_id
      t.datetime :activated_at
      t.datetime :reactivate_at
      t.string :video_link
      t.boolean :has_photo, default: false
      t.boolean :has_vk, default: false
      t.boolean :has_fb, default: false
      t.boolean :has_ok, default: false
      t.boolean :has_youtube, default: false

      t.timestamps null: false
    end
  end
end
