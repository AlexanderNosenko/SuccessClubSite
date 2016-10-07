class Business < ActiveRecord::Base
  has_many :user_businesses, dependent: :destroy
  has_many :users, through: :user_businesses
end
