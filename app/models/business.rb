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
    return nil if count == 0
    sum = Comment.where.not(rate: nil).sum(:rate)
    sum / count
  end

  def get_link user
    link = link_template
    user.ancestors.sort_by { |ancestor| ancestor.depth }.each do |ancestor|
      settings = ancestor.business_settings(self)
      unless settings.nil?
        unless settings.block_reg || settings.partner_link.link.nil?
          link = settings.partner_link.link
          break
        end
      end
    end
    if link == link_template
      link = 'https://redex.red/reg'
    end
  end
end
