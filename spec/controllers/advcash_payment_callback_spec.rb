require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "#responce_status" do
    it "ADVCASH increae number of payments in the system" do
      ActiveRecord.stub(:find).and_return(User.find(3))
      expect { 
      	post :responce_status, "ac_src_wallet"=>"Bitcoin", "ac_dest_wallet"=>"U757631680131", "ac_amount"=>"5.00", "ac_merchant_amount"=>"5.00", "ac_merchant_currency"=>"USD", "ac_fee"=>"0.00", "ac_buyer_amount_without_commission"=>"0.007109", "ac_buyer_amount_with_commission"=>"0.007109", "ac_buyer_currency"=>"BTC", "ac_transfer"=>"103bf741-913c-4074-8237-bbfe65018ce7", "ac_sci_name"=>"Professionals Club", "ac_start_date"=>"2016-10-29 21:09:31", "ac_order_id"=>"CMGJFRCD", "ac_ps"=>"BITCOIN", "ac_transaction_status"=>"COMPLETED", "ac_comments"=>"Adcanced Cash payment.", "ac_hash"=>"e54d308255ad450252b3d5a6dc2562849d3cf54f1413b217d6875259db70bd7f", "utf8"=>"✓", "user_id"=>"1205", "authenticity_token"=>"kTbVzWDmVbE7IilnKY8ALQoJXbDaiCbnD9LV1YqNUYYdRdvdHjZFL8DbK8LKE/AuoLUVaiC9EaIOUi4NEL6hQw==", "id"=>"advcash"
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end
end

