class PartnerLink < ActiveRecord::Base
  belongs_to :user
  has_many :landings
end
