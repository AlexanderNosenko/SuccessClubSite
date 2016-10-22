class Payment < ActiveRecord::Base
  belongs_to :to_user, class_name: 'User'
  belongs_to :from_user, class_name: 'User'
  
  validate :user_exists
  
  def user_exists
    errors.add(:user, "is not present") unless (to_user.present? || from_user.present?)
  end
end
