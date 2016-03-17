require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'

module BlackhawkApi
  class AccountRepository < Client
    # This operation is used to get an account number for the given product and amount.
    def create request
      post AccountProcessingInformation.create(request.product_id, request.amount, 
        request.currency, request.transaction_time, request.reference_number,
        request.store_number, request.terminal_number, request.base_transaction_id,
        request.message_reason_code)
    end
    
    # This operation retrieves account information excluding balance information for the specified account ID.
    def find account_id
      get AccountProcessingInformation.find account_id
    end
    
    # This operation retrieves account information including balance information for the specified account ID.
    def find_with_balance account_id
      get AccountProcessingInformation.find_with_balance account_id
    end
    
    # This operation queries an account by using a combination of account number, product line ID and account type.
    def lookup request
      get AccountProcessingInformation.lookup(request.account_number, 
        request.product_line_id, request.account_type)
    end
  end
end