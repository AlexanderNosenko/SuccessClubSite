require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "POST #responce_status" do
    it "ADVCASH increae number of payments in the system" do
    
      expect { 
      	post :responce_status, :id => "advcash", 
      	"ac_src_wallet"=>"Bitcoin", 
        "ac_dest_wallet"=>"U757631680131", 
        "ac_amount"=>"1.00", 
        "ac_merchant_amount"=>"1.00", 
        "ac_merchant_currency"=>"USD", 
        "ac_fee"=>"0.00", 
        "ac_buyer_amount_without_commission"=>"0.001608", 
        "ac_buyer_amount_with_commission"=>"0.001608", 
        "ac_buyer_currency"=>"BTC", 
        "ac_transfer"=>"2beb4773-c857-4883-bbb4-5d39db2f563a", 
        "ac_sci_name"=>"Professionals Club", 
        "ac_start_date"=>"2016-10-18 19:41:54", 
        "ac_order_id"=>"TLAUIMGX", 
        "ac_ps"=>"BITCOIN", 
        "ac_transaction_status"=>"PENDING", 
        "ac_comments"=>"Adcanced Cash payment.", 
        "utf8"=>"✓", 
        "user_id"=>"6", 
        "authenticity_token"=>"EokDnHgn82wEH/ghcPivkWJzGzgBzbX7 O4UgioWyatQke1B824BrLb/6U7QBmCvu0FWFxaRLyYxCDbuXP3/Yg=="
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end
end