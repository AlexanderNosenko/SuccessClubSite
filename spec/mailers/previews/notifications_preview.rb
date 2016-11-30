# Preview all emails at http://localhost:3000/rails/mailers/notifications
class NotificationsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifications/role_reset
  def role_reset
    Notifications.role_reset
  end

end
