class Wallet < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  after_initialize :init

  def init
  	self.main_balance ||= 0
  	self.bonus_balance ||= 0
  end
end
