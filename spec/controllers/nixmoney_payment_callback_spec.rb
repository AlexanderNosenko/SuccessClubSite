require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "#responce_status" do
    it "NIX MONEY increae number of payments in the system" do
    
      expect { 
      	post :responce_status, :id => "nixmoney", 
      	"user_id" => 2, 
      	'PAYMENT_ID' => '1',
  	  	'PAYEE_ACCOUNT' => '***REMOVED***',
  	  	'PAYMENT_AMOUNT' => '1.00',
  	  	'PAYMENT_UNITS' => 'USD',
  	  	'PAYMENT_BATCH_NUM' => '***REMOVED***',
  	  	'PAYER_ACCOUNT' => '***REMOVED***',
  	  	'V2_HASH' => '***REMOVED***',
  	  	'TIMESTAMPGMT' => '1474215852'
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end

end