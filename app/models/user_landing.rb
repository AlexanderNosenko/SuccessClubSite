class UserLanding < ActiveRecord::Base
  belongs_to :user
  belongs_to :landing
end
