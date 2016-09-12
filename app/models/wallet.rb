class Wallet < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  after_initialize :init

  def init
  	self.main_balance ||= 0
  	self.bonus_balance ||= 0
  	# if self.id < 500:
  	#   self.bonus_balance ||= 200
  	# end
  end
end
