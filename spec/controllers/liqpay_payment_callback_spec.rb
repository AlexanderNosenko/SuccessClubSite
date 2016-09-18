require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "POST #responce_status" do
    it "LIQPAY increae number of payments in the system" do
    

      expect { 
      	post :responce_status, :id => "liqpay", 
      	"signature" => 'vzi41w1KZANgzUgSohrkcpa0p6k==', 
      	'data' => 'eyJ2ZXJzaW9uIjoiMyIsImFjdGlvbiI6InBheSIsImFtb3VudCI6IjEwIiwiY3VycmVuY3kiOiJVQUgiLCJkZXNjcmlwdGlvbiI6Ik5vIGRlc2MgeWV0IiwiY3VzdG9tZXIiOiI2Iiwic2VydmVyX3VybCI6Imh0dHA6Ly9pbXByb2YuY2x1Yi9maW5hbmNlX2FwaS9yZXNwb25jZS1zdGF0dXMvbGlxcGF5IiwicmVzdWx0X3VybCI6Imh0dHA6Ly9pbXByb2YuY2x1Yi9maW5hbmNlX2FwaS9zdWNjZXNzL2xpcXBheSIsImxhbmd1YWdlIjoicnUiLCJzdGF0dXMiOiJzdWNjZXNzIiwicHVibGljX2tleSI6Imk5MTY3MDc3MTM1OCJ9='
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end

end