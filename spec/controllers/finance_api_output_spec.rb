require 'rails_helper'
# require 'rspec/mocks'
# require 'rspec/mocks/spec_methods'
# require 'rspec/mocks/standalone'
RSpec.describe FinanceApiController, type: :controller do

  describe "GET #output" do
    # @controller.stub!(:current_user).and_return()
    
    it "Withdrawal Increae number of Withdrawal if available balance in the system" do
      allow(controller).to receive(:current_user).and_return(User.find(6))  

      expect { 
          post :output, :user_id => 6, :amount => 1, :system_output => "Liqpay"
      }.to  change { Withdrawal.count }
        # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
        # expect(response).to have_http_status(200)
    end
  end

end