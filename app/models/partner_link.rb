class PartnerLink < ActiveRecord::Base
  belongs_to :user

  has_many :user_landings
  has_many :user_businesses

  validates_presence_of :user, :link
end
