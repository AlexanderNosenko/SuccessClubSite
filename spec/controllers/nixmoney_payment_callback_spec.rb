require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "POST #responce_status" do
    it "NIX MONEY increae number of payments in the system" do
    
      expect { 
      	post :responce_status, :id => "nixmoney", 
      	"user_id" => 2, 
      	'PAYMENT_ID' => 'NULL',
  	  	'PAYEE_ACCOUNT' => '***REMOVED***',
  	  	'PAYMENT_AMOUNT' => '1.00',
  	  	'PAYMENT_UNITS' => 'USD',
  	  	'PAYMENT_BATCH_NUM' => '607859',
  	  	'PAYER_ACCOUNT' => '***REMOVED***',
  	  	'V2_HASH' => 'F56D5CB00BA5F3CE1A6DCC89C0394A88',
  	  	'TIMESTAMPGMT' => '1474210833'
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end

end