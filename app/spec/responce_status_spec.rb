require File.expand_path("../../../config/environment", __FILE__)

describe FinanceApiController, :type => :controller do
	describe "GET responce_status" do

      it "should return true if parameter are all good" do
      	params = {}
      	params['PAYMENT_ID'] = 1
	  	params['PAYEE_ACCOUNT'] = 
	  	params['PAYMENT_AMOUNT'] = 1
	  	params['PAYMENT_UNITS'] ='USD'
	  	params['PAYMENT_BATCH_NUM'] = ''
	  	params['PAYER_ACCOUNT'] = 's12d12'
	  	params['TIMESTAMPGMT'] = 121212
	  	params['user_id'] = 1
	  	params['V2_HASH'] = '\xE9\xB7\xE5an\x8A$\x0EWH\x11\xB3\x14\xE3w\xAB'
	  	
	  	get '/finance_api/responce_status'	
      	response.should redirect_to(user_path(payer), successful_payment: params['PAYEE_ACCOUNT'])
      end
    end
end