require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "POST #responce_status" do
    it "PERFECT MONEY increae number of payments in the system" do
    
      expect { 
      	post :responce_status, :id => "perfectmoney", 
      	"user_id" => 6, 
      	'PAYMENT_ID' => 'AB-123',
	  	'PAYEE_ACCOUNT' => 'U123456',
	  	'PAYMENT_AMOUNT' => 1,
	  	'PAYMENT_UNITS' => 'USD',
	  	'PAYMENT_BATCH_NUM' => '789012',
	  	'PAYER_ACCOUNT' => 'U456789',
	  	'V2_HASH' => '59A3A374DFEEA51097891324414C9D12',
	  	'TIMESTAMPGMT' => '876543210'
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end

end
