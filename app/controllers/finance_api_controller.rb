class FinanceApiController < ApplicationController
  require 'digest'
  
  def responce_status
	
    render :status => 403 if params['V2_HASH'] != check_hash(params_for_check)
  	begin 
  		payer = User.find(params['user_id'])
  	rescue
  		# raise ActiveRecord::RecordNotFound
  	end
  	payment = Payment.new
  	payment.user_id = payer.id
  	payment.amount = params['PAYEE_ACCOUNT']
  	
  	raise ActiveRecord::RecordInvalid unless payment.save()

  	redirect_to_user_profile_after_payment(true)
  	

  end

  def success
	 redirect_to_user_profile_after_payment(true)
  end

  def error
  	redirect_to_user_profile_after_payment(false)
  end

  private
  def redirect_to_user_profile_after_payment(status)
  	redirect_to user_path(payer), payment_status: status, payment_amount: params['PAYEE_ACCOUNT']
  end
  def check_hash values
  	a = (Digest::MD5.new).digest values.join(":") 
  end
  def params_for_check
  	#Important to preserve the order.
  	#PAYMENT_ID:PAYEE_ACCOUNT:PAYMENT_AMOUNT:PAYMENT_UNITS:PAYMENT_BATCH_NUM:PAYER_ACCOUNT:PasswordMD5:TIMESTAMPGMT
 
  	params_available = !params['PAYER_ACCOUNT'].nil?
  	if params_available
	  	status_params = [params['PAYMENT_ID']]
	  	status_params.push(params['PAYEE_ACCOUNT'])
	  	status_params.push(params['PAYMENT_AMOUNT'])
	  	status_params.push(params['PAYMENT_UNITS'])
	  	status_params.push(params['PAYMENT_BATCH_NUM'])
	  	status_params.push(params['PAYER_ACCOUNT'])
	  	status_params.push((Digest::MD5.new).digest "password" )
	  	status_params.push(params['TIMESTAMPGMT'])
	  	status_params
	  else
      []
    end
  end
end
