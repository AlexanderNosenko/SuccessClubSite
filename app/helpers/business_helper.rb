module BusinessHelper

	def activation_btn(business)
	    raw(
	    	'<div class="business-btn business-add-btn activate-business-btn" ' + 
	    	(business.activated(current_user.id) ? 'disabled' : '') +'>' + 
	    	(business.activated(current_user.id) ? 'Активирован' : 'Активировать') +
	    	'</div>'
	    	)
	end

	def active_class id
		params[:id] == id ? "active" : ""
	end
end
