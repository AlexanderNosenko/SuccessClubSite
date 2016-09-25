class Withdrawal < ActiveRecord::Base

	def allow
		self.status = true;
		self.save()
	end
	def deny
		self.status = false;
		self.save()
	end
	def user
		User.find(self.user_id)
	end
end
