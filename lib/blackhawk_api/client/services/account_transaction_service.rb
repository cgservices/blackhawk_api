require "blackhawk_api/client/services/service_base"

module BlackhawkApi
  # Application Service for Transactions.
  class TransactionService < BlackhawkService
    def initialize(transaction_repository = nil, error_handler = nil)
      super(error_handler)
      @transactions = transaction_repository ||= TransactionRepository.new
    end
    
    def create request
      perform request do
        # TODO: Implementation of .. @transactions.create
      end
    end
    
    def find transaction_id
      perform request do
        @transactions.find transaction_id
      end
    end
    
    def find_by_ids request
      perform request do
        @transactions.find_by_ids request.transaction_ids
      end
    end
    
    def find_by_account_id request
      perform request do
        @transactions.find_by_account_id request.account_id
      end
    end
    
    def find_by_correlation_id request
      perform request do
        @transactions.find_by_correlation_id request.correlation_id
      end
    end
    
    def correlate request
      perform request do
        @transactions.correlate request.transaction_ids
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