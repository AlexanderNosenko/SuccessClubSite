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
