class UserBusiness < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  belongs_to :partner_link
end
