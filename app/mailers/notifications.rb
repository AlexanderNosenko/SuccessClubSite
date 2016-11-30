class Notifications < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.role_reset.subject
  #
  default from: "notify@improf.club"


  def role_reset user
    mail to: user.email, subject: "Статус Партнер"
  end
end
