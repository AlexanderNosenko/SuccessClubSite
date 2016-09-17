require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "POST #responce_status" do
    it "returns http success" do
      mock_params = {}
      
      mock_params['ac_hash'] = "9167e8c4cd27e1edcb67064be48cdb6d755149b2bf1f852496d4353d8510b98d"
      mock_params['ac_transfer'] = "235f9d0b-b48f-462c-9949-621c4930490c"
      mock_params['ac_start_date'] = "2012-06-23 12:30:00"
      mock_params['ac_sci_name'] = "My Shop"
      mock_params['ac_src_wallet'] = 'U123456789012'
      mock_params['ac_dest_wallet'] = 'U210987654321'
      mock_params['ac_order_id'] = 123456
      mock_params['ac_amount'] = '123.45'
      mock_params['ac_merchant_currency'] = "USD"

 	  
      wallet = Wallet.find_by(user_id: 6)
      puts "walet  before requst" + wallet.main_balance.to_s
      balance_prev = wallet.main_balance
      post :responce_status, :id => "advcash", "user_id" => 6, "ac_hash":"1cd6c127c5c49b6d5060cec4bdbf06608216c0c11cc76acebb546be0f7081afd","ac_transfer":"235f9d0b-b48f-462c-9949-621c4930490c","ac_start_date":"2012-06-23 12:30:00","ac_sci_name":"My Shop","ac_src_wallet":"U123456789012","ac_dest_wallet":"U210987654321","ac_order_id":"123456","ac_amount":"123.45","ac_merchant_currency":"USD",'ac_transaction_status':"COMPLETED"
	  
      expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end

end
