class AddDatesToUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base
  end

  def change
  	add_column :users, :came_from, :string, default: 'social_networks'
  	add_column :users, :activated_at, :datetime
  	add_column :users, :reactivate_at, :datetime
  end
end
