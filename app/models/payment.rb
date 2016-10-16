class Payment < ActiveRecord::Base
	# after_save do |self|

	# 	wallet = Wallet.find_by(user_id: self.to_user_id)
	# 	wallet.main_balance += self.amount 
	# 	wallet.save
	# end
	belongs_to :to_user, class_name: 'User'
	belongs_to :from_user, class_name: 'User'
end
