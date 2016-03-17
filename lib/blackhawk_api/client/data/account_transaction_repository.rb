require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'

module BlackhawkApi
  class AccountTransactionRepository < Client
    # This operation creates a new account transaction 
    def create request
      # TODO: implementation 
    end
    
    # This operation retrieves full account transaction information for the specified transaction ID.
    def find account_transaction_id
      get AccountTransaction.find account_transaction_id
    end
    
    # This operation queries account transactions by transaction IDs.
    def find_by_ids request
      get AccountTransaction.find_by_ids request.transaction_ids
    end
    
    # This operation queries account transactions associated with the given account ID.
    def find_by_account_id request
      get AccountTransaction.find_by_account_id request.account_id
    end
    
    # This operation queries account transactions associated with the given correlation ID.
    def find_by_correlation_id request
      get AccountTransaction.find_by_correlation_id request.correlation_id
    end
    
    # This operation groups a set of account transactions using a correlation ID.
    def correlate request
      # TODO: implementation
    end
  end
end