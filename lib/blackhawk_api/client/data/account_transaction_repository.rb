require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'

module BlackhawkApi
  # Repository for account transactions.
  class AccountTransactionRepository < Client
    # This operation creates a new account transaction.
    # @param request The request object to create a new account transaction.
    # @return The HTTP response of the POST request with the newly created account transaction.
    def create(request)
      post AccountTransaction.new.create request
    end

    # This operation retrieves full account transaction information for the specified transaction ID.
    # @param account_transaction_id The identifier of the account transaction.
    # @return The HTTP response of the GET request with the account transaction.
    def find(account_transaction_id)
      get AccountTransaction.new.find account_transaction_id
    end

    # This operation queries account transactions by transaction IDs.
    # @param request The request object with transaction_ids to find.
    # @return The HTTP response of the GET request with the account transactions.
    def find_by_ids(request)
      get AccountTransaction.new.find_by_ids request.transaction_ids
    end

    # This operation queries account transactions associated with the given account ID.
    # @param request The request object with the account id.
    # @return The HTTP response of the GET request with the account transactions.
    def find_by_account_id(account_id)
      get AccountTransaction.new.find_by_account_id account_id
    end

    # This operation queries account transactions associated with the given correlation ID.
    # @param request The request object with the correlation id.
    # @return The HTTP response of the GET request with the account transactions.
    def find_by_correlation_id(request)
      get AccountTransaction.new.find_by_correlation_id request.correlation_id
    end

    # This operation groups a set of account transactions using a correlation ID.
    # @param request The request object with the transaction ids to correlate.
    # @return The HTTP response of the POST request with the correlation id.
    def correlate(request)
      post AccountTransaction.new.correlate request.transaction_ids
    end
  end
end
