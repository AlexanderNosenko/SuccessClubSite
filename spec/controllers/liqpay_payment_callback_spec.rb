require 'rails_helper'

RSpec.describe FinanceApiController, type: :controller do

  describe "POST #responce_status" do
    it "LIQPAY increae number of payments in the system" do
    	
      expect { 
      	post :responce_status, :id => "liqpay", 
      	"signature" => "bIwY+KoJbqteJjlmtmqu1rMEVkg=", 
      	'data' => "eyJhY3Rpb24iOiJwYXkiLCJwYXltZW50X2lkIjoyNDYzNDMyODgsInN0YXR1cyI6ImZhaWx1cmUiLCJlcnJfY29kZSI6Ijk4NTkiLCJlcnJfZGVzY3JpcHRpb24iOiJJbnN1ZmZpY2llbnQgZnVuZHMiLCJ2ZXJzaW9uIjozLCJ0eXBlIjoiYnV5IiwicGF5dHlwZSI6ImNhcmQiLCJwdWJsaWNfa2V5IjoiaTkxNjcwNzcxMzU4IiwiYWNxX2lkIjo0MTQ5NjMsIm9yZGVyX2lkIjoiT0NVT0dDT0UxNDc0MjEwNzIwMTU3OTU5IiwibGlxcGF5X29yZGVyX2lkIjoiSDZLS1Y1NVoxNDc0MjEwNzUyODY0NjU3IiwiZGVzY3JpcHRpb24iOiJObyBkZXNjIHlldCIsInNlbmRlcl9jYXJkX21hc2syIjoiNDc5MDgyKjM4Iiwic2VuZGVyX2NhcmRfYmFuayI6IkpTQyBTdGF0ZSBTYXZpbmdzIEJhbmsgb2YgVWtyYWluZSAoSnNjIE9zY2hhZGJhbmspIiwic2VuZGVyX2NhcmRfdHlwZSI6InZpc2EiLCJzZW5kZXJfY2FyZF9jb3VudHJ5Ijo4MDQsImlwIjoiMTg4LjE2My43MS41IiwiYW1vdW50IjoxLjAsImN1cnJlbmN5IjoiVVNEIiwic2VuZGVyX2NvbW1pc3Npb24iOjAuMCwicmVjZWl2ZXJfY29tbWlzc2lvbiI6MC4wMywiYWdlbnRfY29tbWlzc2lvbiI6MC4wLCJhbW91bnRfZGViaXQiOjI2LjA0LCJhbW91bnRfY3JlZGl0IjoyNi4wNCwiY29tbWlzc2lvbl9kZWJpdCI6MC4wLCJjb21taXNzaW9uX2NyZWRpdCI6MC43MiwiY3VycmVuY3lfZGViaXQiOiJVQUgiLCJjdXJyZW5jeV9jcmVkaXQiOiJVQUgiLCJzZW5kZXJfYm9udXMiOjAuMCwiYW1vdW50X2JvbnVzIjowLjAsIm1waV9lY2kiOiI2IiwiaXNfM2RzIjpmYWxzZSwiY3VzdG9tZXIiOiIyIiwiY3JlYXRlX2RhdGUiOjE0NzQyMTA3NTkwODUsImVuZF9kYXRlIjoxNDc0MjEwNzU5MDg1LCJ0cmFuc2FjdGlvbl9pZCI6MjQ2MzQzMjg4LCJjb2RlIjoiOTg1OSJ9"
		}.to  change { Payment.count }
      # expect(wallet.main_balance).to   eq(balance_prev + mock_params['ac_amount'].to_f)
      # expect(response).to have_http_status(200)
    end
  end

end