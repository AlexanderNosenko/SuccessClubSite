module UserHelper
    def distribute_money(user, amount)
    	user.ancestors.reverse.each do |ancestor|
    		max_depth = Role.info_select.find(ancestor.role_id).partnership_depth
    		depth = calculate_depth(ancestor, user) 
    		unless depth > max_depth
    			percent = PartnershipDepth.find(depth).percent
    			ancestor.wallet.bonus_balance += amount * percent / 100 
                ancestor.wallet.save
    		end
    	end
    end

    def calculate_depth(user, descendant)
        if user.descendant_ids.include? descendant.id
    		descendant.depth - user.depth
    	else
    		nil
    	end
    end
end
