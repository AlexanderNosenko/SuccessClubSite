class Business < ActiveRecord::Base
  has_many :user_businesses, dependent: :destroy
  has_many :users, through: :user_businesses
  scope :recent, -> { where("created_at > ?",1.month.ago) }
  scope :problem, -> { where(status: nil) }

  def self.newest_first
    order(created_at: :desc)
  end

  def self.paginate_by page
  	paginate(per_page: 4, page: page)
  end
end
