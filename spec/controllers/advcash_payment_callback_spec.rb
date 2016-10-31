require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "#responce_status" do
    it "ADVCASH increae number of payments in the system" do
    
      expect { 
      	post :responce_status, :id => "advcash","ac_src_wallet"=>"Bitcoin", "ac_dest_wallet"=>"U757631680131", "ac_amount"=>"5.00", "ac_merchant_amount"=>"5.00", "ac_merchant_currency"=>"USD", "ac_fee"=>"0.00", "ac_buyer_amount_without_commission"=>"0.007247", "ac_buyer_amount_with_commission"=>"0.007247", "ac_buyer_currency"=>"BTC", "ac_transfer"=>"d53d9531-c95f-4703-807d-553312547783", "ac_sci_name"=>"Professionals Club", "ac_start_date"=>"2016-10-30 19:27:31", "ac_order_id"=>"BVRTJNOT", "ac_ps"=>"BITCOIN", "ac_transaction_status"=>"PENDING", "ac_comments"=>"Adcanced Cash payment.", "ac_hash"=>"a0963eb883cae42c95aea9d830a575ffd3105f844dc5bcb3d5dcfb842b087944", "utf8"=>"✓", "user_id"=>"1370", "authenticity_token"=>"gZL+CeiBd0TTXOPFhe/uqmqTVYteIhWdxLMS6cQgezVftdlqEA16L5c8GsWdKAX3L+QHWF5twElEnf1DMfpwGA=="
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end
end