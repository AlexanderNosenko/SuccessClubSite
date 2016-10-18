class Landing < ActiveRecord::Base
  has_many :user_landings, dependent: :destroy
  has_many :users, through: :user_landings
  belongs_to :business

  scope :recent, -> { where("updated_at > ?",1.month.ago).order(updated_at: :desc) }
  scope :problem, -> { where(status: nil).order(updated_at: :desc) }
  
  def self.by_business business_id
    where(business_id: business_id)
  end

  def self.newest_first
    order(created_at: :desc)
  end
end
