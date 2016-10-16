class Landing < ActiveRecord::Base
  has_many :user_landings, dependent: :destroy
  has_many :users, through: :user_landings
  belongs_to :business
end
