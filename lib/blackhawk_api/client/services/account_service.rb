require "blackhawk_api/client/services/service_base"

module BlackhawkApi
  # Application Service for Accounts.
  class AccountService < BlackhawkService
    def initialize(account_repository = nil, error_handler = nil)
      super(error_handler)
      @accounts = account_repository ||= AccountRepository.new
    end
    
    # This operation is used to get an account number for the given product and amount.
    def create request
      web_response, results = perform request do
        @accounts.create request
      end
      AccountCreatedResponse.new(web_response)
    end
    
    # This operation uses an account_id to retrieve account information.
    # This operation can be used instead of find_with_balance if the current balance
    # is not required.
    def find account_id
      web_response, results = perform request do
        @accounts.find request.account_id
      end
      AccountDetailsResponse.new(web_response)
    end
    
    # This API operation uses an account_id to retrieve account information,
    # including the balance. Updates are reflected in the current balance.
    def find_with_balance account_id
      web_response, results = perform request do
        @accounts.find_with_balance request.account_id
      end
      AccountDetailsResponse.new(web_response)
    end
    
    # This API operation queries an account using Account Number,
    # an optional PIN, ProductLineID and Account Type.
    # If the account is not found it returns no content.
    def lookup request
      web_response, results = perform request do
        @accounts.lookup request
      end
      AccountLocationResponse.new(web_response)
    end
  end
end