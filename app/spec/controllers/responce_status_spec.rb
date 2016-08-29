require File.expand_path("../../../../config/environment", __FILE__)
require 'spec_helper'
describe FinanceApiController, :type => :controller do
	describe "GET responce_status" do

      it "should return true if parameter are all good" do
   		
	  	get :responce_status, :PAYMENT_ID => 1, 
	  	:PAYEE_ACCOUNT => '', :PAYMENT_AMOUNT => 1, :PAYMENT_UNITS => 'USD', 
	  	:PAYMENT_BATCH_NUM => '', :PAYER_ACCOUNT => 's12d12', :TIMESTAMPGMT => 121212,
	  	:user_id => 1, :V2_HASH => '\x99ve\x9A\xF7\xE9m1\xAEB2\xA9\xC5\xA5\xE3'

      	response.should redirect_to(user_path(payer), successful_payment: params['PAYEE_ACCOUNT'])
      end
    end
end