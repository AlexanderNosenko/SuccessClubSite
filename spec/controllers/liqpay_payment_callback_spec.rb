require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "POST #responce_status" do
    it "LIQPAY increae number of payments in the system" do
    	
      expect { 
      	post :responce_status, :id => "liqpay", 
      	"signature" => "Z4GTseuT3S5QdSIODoejDnK2EwE=", 
      	'data' => "eyJhY3Rpb24iOiJwYXkiLCJwYXltZW50X2lkIjoyNTI1MzA4NTMsInN0YXR1cyI6IndhaXRfYWNjZXB0IiwidmVyc2lvbiI6MywidHlwZSI6ImJ1eSIsInBheXR5cGUiOiJjYXJkIiwicHVibGljX2tleSI6Imk5MTY3MDc3MTM1OCIsImFjcV9pZCI6NDE0OTYzLCJvcmRlcl9pZCI6IkxCNUZDWTlTMTQ3NTA2MTU1NzE2NjU1OCIsImxpcXBheV9vcmRlcl9pZCI6IklKNVdYRkoyMTQ3NTA2MTU3NjcyMDU4MCIsImRlc2NyaXB0aW9uIjoiTm8gZGVzYyB5ZXQiLCJzZW5kZXJfY2FyZF9tYXNrMiI6IjQ3OTA4MiozOCIsInNlbmRlcl9jYXJkX2JhbmsiOiJKU0MgU3RhdGUgU2F2aW5ncyBCYW5rIG9mIFVrcmFpbmUgKEpzYyBPc2NoYWRiYW5rKSIsInNlbmRlcl9jYXJkX3R5cGUiOiJ2aXNhIiwic2VuZGVyX2NhcmRfY291bnRyeSI6ODA0LCJpcCI6IjE4OC4xNjMuNzEuNSIsImFtb3VudCI6MS4wLCJjdXJyZW5jeSI6IlVBSCIsInNlbmRlcl9jb21taXNzaW9uIjowLjAsInJlY2VpdmVyX2NvbW1pc3Npb24iOjAuMDMsImFnZW50X2NvbW1pc3Npb24iOjAuMCwiYW1vdW50X2RlYml0IjoxLjAsImFtb3VudF9jcmVkaXQiOjEuMCwiY29tbWlzc2lvbl9kZWJpdCI6MC4wLCJjb21taXNzaW9uX2NyZWRpdCI6MC4wMywiY3VycmVuY3lfZGViaXQiOiJVQUgiLCJjdXJyZW5jeV9jcmVkaXQiOiJVQUgiLCJzZW5kZXJfYm9udXMiOjAuMCwiYW1vdW50X2JvbnVzIjowLjAsImF1dGhjb2RlX2RlYml0IjoiOTA0Mzg2IiwicnJuX2RlYml0IjoiMDAwNDYzNDQxNDA3IiwibXBpX2VjaSI6IjYiLCJpc18zZHMiOmZhbHNlLCJjdXN0b21lciI6IjIiLCJ0cmFuc2FjdGlvbl9pZCI6MjUyNTMwODUzfQ"
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end

end