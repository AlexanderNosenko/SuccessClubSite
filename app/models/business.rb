class Business < ActiveRecord::Base
  has_many :user_businesses, dependent: :destroy
  has_many :users, through: :user_businesses
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :name

  scope :recent, -> { where("created_at > ?",1.month.ago) }
  scope :problem, -> { where(status: nil) }

  def self.newest_first
    order(created_at: :desc)
  end

  def self.paginate_by page
  	paginate(per_page: 4, page: page)
  end

  def rating
    count = Comment.where.not(rate: nil).count
    sum = Comment.where.not(rate: nil).sum(:rate)
    sum / count
  end
end
