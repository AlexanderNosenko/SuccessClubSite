class FinanceApiController < ApplicationController
  before_action :prepare_payer
  require 'digest'
  
  def responce_status
	   
    if params[:id] == 'privat_24'
      
      render :status => 422 if params['data'].blank?
  
      liqpay = Liqpay::Liqpay.new()
      sign = liqpay.str_to_sign(
       liqpay.private_key  + 
       params['data'] +
       liqpay.private_key
      )
          
      if params['signature'] == sign
       require "base64"
       require 'json'
       data = JSON.parse(Base64.decode64(params['data']))
       
        if data['status'] == "wait_accept"
          
          payment = Payment.find(data['order_id'].to_i)
          payment.status = 'paid'
          raise ActiveRecord::RecordInvalid unless payment.save()

          redirect_to_user_profile_after_payment(true)
        end
      else
        redirect_to_user_profile_after_payment(false)
      end
    else
      render :status => 403 if params['V2_HASH'] != check_hash(params_for_check)
    
    	payment = Payment.new
    	payment.user_id = @payer.id
    	payment.amount = params['PAYEE_ACCOUNT']
    	
    	raise ActiveRecord::RecordInvalid unless payment.save()

    	redirect_to_user_profile_after_payment(true)
  	end

  end

  def success
	 redirect_to_user_profile_after_payment(true)
  end

  def error
  	redirect_to_user_profile_after_payment(false)
  end

  def payment_form
    service = {
      'name' => params['service_name'],
      'amount' => params['amount']
    }
    responce = get_payment_form(service)
    respond_to do |format|
      format.html do
        render inline: responce
      end
      format.js do
        render inline: responce
      end
    end
    
  end

  private
  def prepare_payer
    begin 
        @payer = User.find(params['user_id'])
    rescue
      # raise ActiveRecord::RecordNotFound
    end
  end
  def get_payment_form( service )
    if service['name'] == 'liqpay'
      liqpay = Liqpay.new
      liqpay.cnb_form({
      :version => '3',
      :action         => "pay",
      :amount         => service['amount'],
      :currency       => "UAH",
      :description    => 'No desc yet',
      :order_id       => current_user.id,
      :server_url => "http://improf.club/finance_api/responce-status/liqpay",
      :result_url => "http://improf.club/finance_api/success/liqpay",
      :language => "ru"
      }).html_safe
    end
  end
  def redirect_to_user_profile_after_payment(status)
  	redirect_to user_path(@payer), payment_status: status, payment_amount: params['PAYEE_ACCOUNT']
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
