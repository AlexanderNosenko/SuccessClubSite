require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "POST #responce_status" do
    it "ADVCASH increae number of payments in the system" do
    
      expect { 
      	post :responce_status, :id => "advcash", 
      	"user_id" => 6, 
      	"ac_hash":"a2f1e212364f1f4b65dddd362d8a9bb260b32581ce72cdfd4107d7ee6925d3b5",
      	"ac_transfer":"235f9d0b-b48f-462c-9949-621c4930490c",
      	"ac_start_date":"2012-06-23 12:30:00",
      	"ac_sci_name":"My Shop",
      	"ac_src_wallet":"U123456789012",
      	"ac_dest_wallet":"U210987654321",
      	"ac_order_id":"123456",
      	"ac_amount":"123.45",
      	"ac_merchant_currency":"USD",
      	'ac_transaction_status':"COMPLETED"	
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end

end
