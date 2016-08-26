# spec/string_calculator_spec.rb
require "finance_api/adv_cash.rb"

describe FinanceApi::AdvCash do
	describe "#get_balances" do
      it "should return balance status" do

		api_name = 'improf.club'
		api_key = 'Ks3_6C3b0g'
		account_email = 'club.mlm30@gmail.com'

		# request = { from: 'USD', to: 'EUR', action: 'SELL', amount: 1.00, note: 'Some note' }

		auth = FinanceApi::AdvCashAuth.new api_name, api_key, account_email
		agent = FinanceApi::AdvCash.new auth
		result = agent.get_balances
		# puts "Transaction ID: #{rult.body[:currency_exchange_response][:return]}"
		result.body[:get_balances_response][:return].length.should be > 0
      end
    end
end