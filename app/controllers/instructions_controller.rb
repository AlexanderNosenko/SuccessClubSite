class InstructionsController < ApplicationController

	def index
		render params[:for]	
	end
end
