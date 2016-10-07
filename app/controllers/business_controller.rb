class BusinessController < ApplicationController

	before_action :prepare_business_list, only: [:inxex]
	
	def index
				
	end
	def activate
		# Businness participation table add row for current user and params[:id]
		redirect_to "/landings/?business_id=#{params[:id]}" 
	end
	private 
	def prepare_business_list
		@businesses = [];
	end

end
