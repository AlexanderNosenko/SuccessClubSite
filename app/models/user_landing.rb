class UserLanding < ActiveRecord::Base
  belongs_to :user
  belongs_to :landing
  belongs_to :partner_link
end
