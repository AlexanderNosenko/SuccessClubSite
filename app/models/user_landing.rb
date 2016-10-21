class UserLanding < ActiveRecord::Base
  belongs_to :user
  belongs_to :landing
  belongs_to :partner_link

  validates_presence_of :user, :landing

  def init
  	self.is_club ||= false
  end
end
