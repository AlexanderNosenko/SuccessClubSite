class Landing < ActiveRecord::Base
  belongs_to :business

  has_many :user_landings, dependent: :destroy
  has_many :users, through: :user_landings
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :name, :price, :path

  scope :recent, -> { where("updated_at > ?",1.month.ago) }
  scope :problem, -> { where(status: nil) }
  
  def preview_image
    'landings/' + name.downcase + '-preview.png'
  end
  def self.by_business business_id
    where(business_id: business_id)
  end

  def self.newest_first
    order(created_at: :desc)
  end

  def self.paginate_by page
  	paginate(per_page: 4, page: page)
  end
end
