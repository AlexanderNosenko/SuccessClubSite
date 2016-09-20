class AddFieldsToLadings < ActiveRecord::Migration
  class Landing < ActiveRecord::Base
  end

  def change
	add_column :landings, :path, :string   # 'user, system'
	add_column :landings, :description, :string  # "user, system"
  end
end
