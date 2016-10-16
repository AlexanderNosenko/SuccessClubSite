module BusinessHelper

	def activation_btn(business)
	    activated  = business.users.include? current_user
	    raw(
	    	'<div class="business-btn business-add-btn '+(activated ? 'disabled' : '')+' activate-business-btn" ' + 
	    	(activated ? 'disabled' : '') +'>' + 
	    	(activated ? 'Активирован' : 'Активировать') +
	    	'</div>'
	    	)
	end

	def active_class id
		params[:id] == id ? "active" : ""
	end
end
