class PartnerLinkController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:landing]

  def partner
    session[:parent_id] = params[:id]
    @parent = User.find(session[:parent_id]) if session[:parent_id]
    redirect_to new_user_registration_path
  end

  def delete
    session[:parent_id] = nil
    respond_to do |format|
      format.html { redirect_to new_user_registration_path }
      format.js { render json: '', status: 200 }
      # format.js { render json: params[:search] }
    end
  end
  def landing
    session[:parent_id] = params[:id]
    params[:password] = nil
    redirect_to new_user_registration_path
  end
end
