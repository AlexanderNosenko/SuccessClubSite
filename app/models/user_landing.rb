class UserLanding < ActiveRecord::Base
  belongs_to :user
  belongs_to :landing
  belongs_to :partner_link

  def init
  	self.is_club ||= false
  end
end
