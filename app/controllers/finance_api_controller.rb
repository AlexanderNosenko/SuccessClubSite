class FinanceApiController < ApplicationController

  before_action :prepare_input_data, except: [:payment_form]

  require 'digest'
  require "base64"
  require 'json'

  def responce_status

    payment = Payment.new
    payment.user_id = @responce_data[:user_id]
    payment.amount = @responce_data[:amount]

    raise actiontiveRecord::RecordInvalid unless payment.save()
    @responce_data[:status] = 'success';
    render json: @responce_data.to_json
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
    render inline: get_payment_form(service)

  end

  private

  def prepare_input_data

    send("adapte_#{params[:id]}_data")

  end

  def adapte_liqpay_data
    
    render :status => 400 if params['data'].blank? || params['signature'].blank? && Rails.env.production?

    liqpay = Liqpay::Liqpay.new
    sign = liqpay.str_to_sign(
     liqpay.instance_values['private_key']  +
     params['data'] +
     liqpay.instance_values['private_key']
    )
    liqpay_data = JSON.parse(Base64.decode64(params['data']))

    render :status => 422 unless Rails.env.development? || params['signature'] == sign && liqpay_data['status'] == "wait_accept"

    make_responce_data(liqpay_data['customer'], liqpay_data['amount'], liqpay_data['currency'])

  end

  def adapte_nixmoney_data
    render :status => 422 if params['V2_HASH'] != make_hash_for_ckeck_from(params_for_check(ENV['NIX_MONEY_PASS']))
    make_responce_data(params['user_id'], params['PAYMENT_AMOUNT'], params['PAYMENT_UNITS'])
  end

  def adapte_perfectmoney_data
    Rails.logger.debug "params.to_json:"
    Rails.logger.debug params.to_json
    render :status => 422 if params['V2_HASH'] != make_hash_for_ckeck_from(params_for_check(ENV['PERFECT_MONEY_PASS']))
    make_responce_data(params['user_id'], params['PAYMENT_AMOUNT'], params['PAYMENT_UNITS'])
  end

  def adapte_advcash_data

    render :status => 400 if params['ac_hash'].blank? && Rails.env.production?
    
    status_params = [params['ac_transfer']]
    status_params.push(params['ac_start_date'])
    status_params.push(params['ac_sci_name'])
    status_params.push(params['ac_src_wallet'])
    status_params.push(params['ac_dest_wallet'])
    status_params.push(params['ac_order_id'])
    status_params.push(params['ac_amount'])
    status_params.push(params['ac_merchant_currency'])
    status_params.push(ENV['ADV_CASH_PASS'])

    sign = make_hash_for_ckeck_from(status_params)

    render :status => 422 unless params['ac_hash'] == sign

    make_responce_data(params['user_id'], params['ac_amount'], params['ac_buyer_currency'])
  end

  def make_responce_data(customer, amount ,currency)
    @responce_data = {
        :user_id => customer,
        :amount => amount,
        :currency => currency
    }
  end

  def get_payment_form( service )
    if service['name'] == 'liqpay'
      liqpay = Liqpay.new
      liqpay.cnb_form({
      :version      => '3',
      :action       => "pay",
      :amount       => service['amount'],
      :currency     => "UAH",
      :description  => 'No desc yet',
      :customer     => current_user.id.to_s,
      :server_url   => "http://improf.club/finance_api/responce-status/liqpay",
      :result_url   => "http://improf.club/finance_api/success/liqpay",
      :language     => "ru"
      }).html_safe
    end
  end

  def redirect_to_user_profile_after_payment(status)
    logger.error "got to redirect"
  	redirect_to user_path(current_user), payment_status: status, payment_amount: @responce_data['amount']
  end

  def make_hash_for_ckeck_from values
  	(Digest::MD5.new).hexdigest(values.join(":")).upcase
  end

  def params_for_check(password)
  	#Important to preserve the order.

    params_available = !params['PAYER_ACCOUNT'].nil?
  	if params_available
	  	status_params = [params['PAYMENT_ID']]
	  	status_params.push(params['PAYEE_ACCOUNT'])
	  	status_params.push(params['PAYMENT_AMOUNT'])
	  	status_params.push(params['PAYMENT_UNITS'])
	  	status_params.push(params['PAYMENT_BATCH_NUM'])
	  	status_params.push(params['PAYER_ACCOUNT'])
	  	status_params.push((Digest::MD5.new).hexdigest(password).upcase)
	  	status_params.push(params['TIMESTAMPGMT'])
	  	status_params
	  else
      []
    end
  end
end
