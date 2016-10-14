class BusinessController < ApplicationController

	before_action :authenticate_user!
	before_action :pro_user
	before_action :prepare_params, only: [:activate]
	# before_action :prepare_business_list, only: [:all_business]
	
	def index

	end

	def business

		if(params[:id] == 'my')
			@businesses = current_user.all_business.paginate(:per_page => 4, :page => params[:page])
		else
			@businesses = eval('Business.' + params[:id]).paginate(:per_page => 4, :page => params[:page])
		end
		render 'all_business'

	end

	def activate
		begin	
		
		parent_link = PartnerLink.find_or_create_by(:user_id => current_user.id, 
			:use_for => params[:id])
		parent_link.update_attribute(:link, ref_link)

		UserBusiness.find_or_create_by(:user_id => current_user.id, 
			:business_id => params[:id]).update_attributes(:partner_link_id => parent_link.id, :block_reg => params['block_reg'])
		
		redirect_to "/landings/?business_id=#{params[:id]}", :notice => 'Поздавляем, бизнес успешно активирован!'

		rescue
		redirect_to business_path('all'), :flash => {:error => 'Что то пошло не так, обратитесь в тех поддержку!'}
		end
	end

	def disactivate
		UserBusiness.find_by(:user_id => current_user.id, :business_id => params[:id]).destroy()
		redirect_to business_path('my'), :notice => 'Вы успешно дезактивировали бизнес!'
	end
	def settings
		@business_settings = UserBusiness.find_by(params[:id])
	end

	def update_settings
		user_busi = UserBusiness.find(params[:id])
		user_busi.update_attribute(:block_reg, params['block_reg'])
		PartnerLink.find_by(:user_id => current_user.id, 
			:use_for => user_busi.business_id).update_attribute(:link, ref_link)
		redirect_to business_settings_path, :notice => "Изменения сохранены!"
	end
	
	private
	def pro_user
		redirect_to '/' unless user_has_rights
	end
	def prepare_params
		if params[:ref_link].blank? || params[:id].blank?
			redirect_to business_path('all'), :flash => {:error => 'Введите свою реверальную ссылку, пожалуйста.'}
		end
		# params.require(:ref_link)
	end
	def ref_link
		ref_link_str = params['ref_link'] || params[:partner_link][:link]
		if redex_business
			'redex_site.com/' + ref_link_str
		else
			ref_link_str
		end
		
	end
	def redex_business
		params[:id] == "1" #Redex business_id
	end
	def prepare_business_list
		
	end

end
