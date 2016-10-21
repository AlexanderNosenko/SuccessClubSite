class Withdrawal < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user

  def allow
  	self.status = true;
  	self.save
  end
  def deny
  	self.status = false;
  	self.save
  end
end
