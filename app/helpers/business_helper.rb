module BusinessHelper

	def activation_btn(business)
	    activated  = business.activated(current_user.id)
	    raw(
	    	'<div class="business-btn business-add-btn '+(activated ? 'disabled' : '')+' activate-business-btn" ' + 
	    	(activated ? 'disabled' : '') +'>' + 
	    	(business.activated(current_user.id) ? 'Активирован' : 'Активировать') +
	    	'</div>'
	    	)
	end

	def active_class id
		params[:id] == id ? "active" : ""
	end
end
