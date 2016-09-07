module UserHelper
    def distribute_money(user, amount)
    	user.ancestors.reverse.each do |ancestor|
    		max_depth = ancestor.role.partnership_depth
    		depth = calculate_depth(ancestor, user) 
    		unless depth > max_depth
    			percent = PartnershipDepth.find(depth).percent
    			ancestor.wallet.bonus_balance += amount * percent / 100 
                ancestor.wallet.save
    		end
    	end
    end

    def calculate_depth(user, descendant)
        if (user.ancestry.nil? and descendant.ancestry.start_with?(user.id.to_s)) or \
            descendant.ancestry.include? user.ancestry
    		descendant.depth - user.depth
    	else
    		nil
    	end
    end
end
