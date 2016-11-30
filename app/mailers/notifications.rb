class Notifications < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.role_reset.subject
  #
  def role_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
