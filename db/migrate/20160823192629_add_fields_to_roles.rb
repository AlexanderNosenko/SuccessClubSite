class AddFieldsToRoles < ActiveRecord::Migration
  class Role < ActiveRecord::Base
  end

  def change
    add_column :roles, :switch_price, :integer
    add_column :roles, :month_price, :integer
    add_column :roles, :spam_per_week, :integer
    add_column :roles, :adv_per_month, :integer
    add_column :roles, :online_event_per_week, :integer
    add_column :roles, :landing_pages_number, :integer
    add_column :roles, :month_team_bonus_ppm, :integer

    add_column :roles, :partnership_depth, :integer

    add_column :roles, :can_edit_video, :bool, default: false
    add_column :roles, :can_start_auction, :bool, default: false
    add_column :roles, :know_partners_backref, :bool, default: false
    add_column :roles, :have_investment_belay, :bool, default: false 
  end
end
