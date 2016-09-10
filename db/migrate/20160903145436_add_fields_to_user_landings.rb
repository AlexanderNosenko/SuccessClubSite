class AddFieldsToUserLandings < ActiveRecord::Migration
  def change
    add_column :user_landings, :partner_link_id, :integer
  end
end
