require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "POST #responce_status" do
    it "ADVCASH increae number of payments in the system" do
    
      expect { 
      	post :responce_status, :id => "advcash", 
      	"user_id" => 6, 
      	"ac_hash":"a2f1e212364f1f4b65dddd362d8a9bb260b32581ce72cdfd4107d7ee6925d3b5",
      	"ac_transfer":"ca14c2d4-bdb8-4a03-967f-b454935dd4d9",
      	"ac_start_date":"2016-09-29 14:06:24",
      	"ac_sci_name":"Professionals Club",
      	"ac_src_wallet":"U856491513177",
      	"ac_dest_wallet":"U757631680131",
      	"ac_order_id":"NFDQXBDT",
      	"ac_amount":"0.20",
      	"ac_merchant_currency":"USD",
      	'ac_transaction_status':"COMPLETED"	
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end
end