class User < ActiveRecord::Base
  belongs_to :role
  before_create :set_default_role

  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  private
  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end

  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
