module BlackhawkApi
  # Application Service for Transactions.
  class TransactionService < ApplicationService
    def initialize(transaction_repository = nil, error_handler = nil)
      super(error_handler)
      @transactions = transaction_repository || AccountTransactionRepository.new
    end

    # This operation creates an account transaction.
    def create(request)
      web_response, results = perform request do
        @transactions.create request.transaction
      end
      Responses::AccountTransactionResponse.new(web_response)
    end

    # This operation retrieves full account transaction information for the
    # specified account transaction identifier.
    def find(transaction_id)
      request = Requests::FindAccountTransactionsByIdsRequest.new([transaction_id])

      web_response, results = perform request do
        @transactions.find transaction_id
      end
      Responses::AccountTransactionResponse.new(web_response)
    end

    # This operation queries account transactions by IDs
    def find_by_ids(request)
      web_response, results = perform request do
        @transactions.find_by_ids request.transaction_ids
      end
      Responses::AccountTransactionListResponse.new(web_response)
    end

    # This operation queries account transactions associated witht he given account ID.
    def find_by_account_id(request)
      web_response, results = perform request do
        @transactions.find_by_account_id request.account_id
      end
      Responses::AccountTransactionListResponse.new(web_response)
    end

    # This operation queries account transactions associated with the given correlation ID.
    def find_by_correlation_id(request)
      web_response, results = perform request do
        @transactions.find_by_correlation_id request.correlation_id
      end
      Responses::AccountTransactionListResponse.new(web_response)
    end

    # This operation groups a set of account transactions using a correlation ID.
    def correlate(request)
      web_response, results = perform request do
        @transactions.correlate request.transaction_ids
      end
      Responses::AccountTransactionCorrelationResponse.new(web_response)
    end
  end
end
