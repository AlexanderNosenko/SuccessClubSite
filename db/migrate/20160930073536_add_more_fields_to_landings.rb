class AddMoreFieldsToLandings < ActiveRecord::Migration
  class Landing < ActiveRecord::Base
  end

  def change
  	add_column :landings, :short_path, :string
  	add_index :landings, :path, unique: true
  	add_index :landings, :short_path, unique: true
    remove_index :landings, :name
  end
end
