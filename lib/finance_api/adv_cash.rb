module FinanceApi
	class AdvCash
	  require 'savon'
	  require 'date'
	  require 'digest'

	  WSDL_URL  = 'https://wallet.advcash.com/wsm/merchantWebService?wsdl'

	  def initialize(auth)
	    @auth = auth
	    @client = Savon.client wsdl: WSDL_URL, endpoint: WSDL_URL

	    @credentials = { api_name: @auth.api_name, authentication_token: @auth.authentication_token,
	      account_email: @auth.account_email }
	  end

	  def validate_accounts(accounts)
	    @client.call :validate_accounts, message: { arg0: @credentials, arg1: accounts }
	  rescue => e
	    raise e.message
	  end

	  def validate_account(account)
	    @client.call :validate_account, message: { arg0: @credentials, arg1: account }
	  rescue => e
	    raise e.message
	  end

	  def withdrawal_through_external_payment_system(payment)
	    @client.call :withdrawal_through_external_payment_system, message: { arg0: @credentials, arg1: payment }
	  rescue => e
	    raise e.message
	  end

	  def validate_withdrawal_through_external_payment_system(payment)
	    @client.call :validate_withdrawal_through_external_payment_system, message: { arg0: @credentials, arg1: payment }
	  rescue => e
	    raise e.message
	  end

	  def get_balances
	    @client.call :get_balances, message: { arg0: @credentials }
	  rescue => e
	    raise e.message
	  end

	  def history(filters)
	    @client.call :history, message: { arg0: @credentials, arg1: filters }
	  rescue => e
	    raise e.message
	  end

	  def find_transaction(transaction_id)
	    @client.call :find_transaction, message: { arg0: @credentials, arg1: transaction_id }
	  rescue => e
	    raise e.message
	  end

	  def make_currency_exchange(wallets, is_amount_in_src_wallet_currency)
	    @client.call :make_currency_exchange, message: { arg0: @credentials, arg1: wallets, arg2: is_amount_in_src_wallet_currency }
	  rescue => e
	    raise e.message
	  end

	  def validate_currency_exchange(wallets)
	    @client.call :validate_currency_exchange, message: { arg0: @credentials, arg1: wallets }
	  rescue => e
	    raise e.message
	  end

	  def validate_email_transfer(wallets)
	    @client.call :validate_email_transfer, message: { arg0: @credentials, arg1: wallets }
	  rescue => e
	    raise e.message
	  end

	  def validate_bank_card_transfer(wallets)
	    @client.call :validate_bank_card_transfer, message: { arg0: @credentials, arg1: wallets }
	  rescue => e
	    raise e.message
	  end

	  def validate_advcash_card_transfer(wallets)
	    @client.call :validate_advcash_card_transfer, message: { arg0: @credentials, arg1: wallets }
	  rescue => e
	    raise e.message
	  end

	  def make_transfer(type_of_transaction, wallets)
	    @client.call :make_transfer, message: { arg0: @credentials, arg1: type_of_transaction, arg2: wallets }
	  rescue => e
	    raise e.message
	  end

	  def make_email_transfer(wallets)
	    @client.call :email_transfer, message: { arg0: @credentials, arg1: wallets }
	  rescue => e
	    raise e.message
	  end

	  def make_transfer_bank_card(wallets)
	    @client.call :transfer_bank_card, message: { arg0: @credentials, arg1: wallets }
	  rescue => e
	    raise e.message
	  end

	  def make_transfer_advcash_card(wallets)
	    @client.call :transfer_advcash_card, message: { arg0: @credentials, arg1: wallets }
	  rescue => e
	    raise e.message
	  end

	  def validate_transfer(type_of_transaction, wallets)
	    @client.call :validate_transfer, message: { arg0: @credentials, arg1: type_of_transaction, arg2: wallets }
	  rescue => e
	    raise e.message
	  end

	  def validation_currency_exchange(request)
	    @client.call :validation_currency_exchange, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def validation_send_money(request)
	    @client.call :validation_send_money, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def validation_send_money_to_advcash_card(request)
	    @client.call :validation_send_money_to_advcash_card, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def validation_send_money_to_bank_card(request)
	    @client.call :validation_send_money_to_bank_card, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def validation_send_money_to_ecurrency(request)
	    @client.call :validation_send_money_to_ecurrency, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def validation_send_money_to_email(request)
	    @client.call :validation_send_money_to_email, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def currency_exchange(request)
	    @client.call :currency_exchange, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def send_money(request)
	    @client.call :send_money, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def send_money_to_advcash_card(request)
	    @client.call :send_money_to_advcash_card, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def send_money_to_bank_card(request)
	    @client.call :send_money_to_bank_card, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def send_money_to_ecurrency(request)
	    @client.call :send_money_to_ecurrency, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end

	  def send_money_to_email(request)
	    @client.call :send_money_to_email, message: { arg0: @credentials, arg1: request }
	  rescue => e
	    raise e.message
	  end
	end

	class AdvCashAuth
	  attr_accessor :api_name
	  attr_accessor :authentication_token
	  attr_accessor :account_email

	  def initialize(api_name, api_key, account_email)
	    @api_name = api_name
	    @authentication_token = self.create_auth_token api_key
	    @account_email = account_email
	  end

	  def create_auth_token(api_key)
	    Digest::SHA256.hexdigest "#{api_key}:#{DateTime.now.new_offset(0).strftime("%Y%m%d:%H")}"
	  end
	end
end
