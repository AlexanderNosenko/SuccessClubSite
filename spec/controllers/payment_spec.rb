require 'rails_helper'
# require 'rspec/mocks'
# require 'rspec/mocks/spec_methods'
# require 'rspec/mocks/standalone'
RSpec.describe Admin::PaymentsController, type: :controller do

  describe "GET #transfer" do
    # @controller.stub!(:current_user).and_return()
    wallet = Wallet.find_by(user_id: 6)
    it "reduces money on from and increases on to" do
      allow(controller).to receive(:current_user).and_return(User.find(6))  
      expect { 
          post :transfer, :from_user_id => "admin@example.com", :to_user_id => "last@mail.com",:amount => 1
      }.to  change { wallet.reload.main_balance }.from(10.0).to(9.0)
        # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
        # expect(response).to have_http_status(200)
    end
  end

end