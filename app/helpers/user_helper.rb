module UserHelper
    def distibute_money(user, amount)
    	user.ancestors.reverse.each do |ancestor|
    		max_depth = ancestor.status.partnership_depth
    		depth = calculate_depth(ancestor, user) 
    		unless depth > max_depth
    			percent = PartnershipDepth.find(depth).percent
    			ancestor.wallet.bonus_balance += amount * percent / 100 
    		end
    	end
    end

    def calculate_depth(user, descendant)
    	if descendant.ancestry.include? user.ancestry
    		descendant.depth - user.depth
    	else
    		nil
    	end
    end
end

module ApplicationHelper
    def is_active_controller(controller_name)
        params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    def get_avatar(user, params = {})
      url = user.avatar_url
      url = 'no_avatar.png' if user.avatar_url.nil?
      image_tag(url, params)
    end
end
