class Payment < ActiveRecord::Base
	# after_save do |self|

	# 	wallet = Wallet.find_by(user_id: self.to_user_id)
	# 	wallet.main_balance += self.amount 
	# 	wallet.save
	# end
end
