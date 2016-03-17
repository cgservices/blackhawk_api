require "blackhawk_api/client/services/service_base"

module BlackhawkApi
  # Application Service for Accounts.
  class AccountService < BlackhawkService
    def initialize(account_repository = nil, error_handler = nil)
      super(error_handler)
      @accounts = account_repository ||= AccountRepository.new
    end
    
    def create request
      perform request do
        # TODO: Implementation
      end
    end
    
    def find account_id
      perform request do
        @accounts.find request.account_id
      end
    end
    
    def find_with_balance account_id
      perform request do
        @accounts.find_with_balance request.account_id
      end
    end
    
    def lookup request
      perform request do
        # TODO: Implementation @accounts.lookup request.
      end
    end
    
    protected
    def perform request, &block
      return if !validate request

      response = yield
      return inspected response
    end
  end
end