class Admin::AdminController < ApplicationController
  layout "../admin/admin/layout"
  before_action :check_for_admin

  private
  def check_for_admin
    current_user.email == ENV['CLUB_ADMIN_EMAIL']
  end
end
