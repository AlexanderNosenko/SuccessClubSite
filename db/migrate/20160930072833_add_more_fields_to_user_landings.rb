class AddMoreFieldsToUserLandings < ActiveRecord::Migration
  class UserLanding < ActiveRecord::Base
  end

  def change
  	add_column :user_landings, :viewed, :integer
  	add_column :user_landings, :registrations, :integer
  	add_column :user_landings, :is_club, :boolean
  end
end
