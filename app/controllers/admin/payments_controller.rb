class Admin::PaymentsController < Admin::AdminController

  def index
    @payments = Payment.order(created_at: :desc).paginate(:per_page => 15, :page => params[:page])
  end
  
  def transfer
  	require 'json'

	render status: 400 if params['from_user_id'].blank? || params['to_user_id'].blank? || params['amount'].blank? 
	from_user = User.find_by(email: params['from_user_id'])
	to_user = User.find_by(email: params['to_user_id'])
	render status: 422 if from_user.blank? || to_user.blank?

	status = User.transaction do 
		from_user.take_money(params['amount'])
		to_user.give_money(params['amount'])
	end
puts "_______________________balance motherfucker" + from_user.wallet.id.to_s#main_balance.to_s
	if(status) 
      flash[:notice] = "Поздравляем! Средства переведены."
    else
      flash[:notice] = "Приносим свои извининия, произошла ошибка, обратитесь в техподдержку."
    end

    redirect_to admin_payments_path

  end

end
