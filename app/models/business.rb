class Business < ActiveRecord::Base
  has_many :user_businesses, dependent: :destroy
  has_many :users, through: :user_businesses
  scope :recent, -> { where("updated_at > ?",1.month.ago).order(updated_at: :desc) }
  scope :problem, -> { where(status: nil).order(updated_at: :desc) }
  def activated user_id
  	true unless UserBusiness.where(user_id: user_id, business_id: self.id).blank?
  end
end
