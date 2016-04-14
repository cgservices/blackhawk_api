require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'

module BlackhawkApi
  # Repository for Accounts.
  class AccountRepository < Client
    # This operation is used to get an account number for the given product and amount.
    # @param request The request object with account processing information.
    # @return Returns the HTTP response of the POST request.
    def create(request)
      post AccountProcessingInformation.create(
        request.product_id,
        request.amount,
        request.currency,
        request.transaction_time,
        request.reference_number,
        request.store_number,
        request.terminal_number,
        request.base_transaction_id,
        request.message_reason_code)
    end

    # This operation retrieves account information excluding balance information for the specified account ID.
    # @param account_id The identification number of the account.
    # @return Returns the HTTP response of the GET request.
    def find(account_id)
      get AccountProcessingInformation.find account_id
    end

    # This operation retrieves account information including balance information for the specified account ID.
    # @param account_id The identification number of the account.
    # @return Returns the HTTP response of the GET request.
    def find_with_balance(account_id)
      get AccountProcessingInformation.find_with_balance account_id
    end

    # This operation queries an account by using a combination of account number, product line ID and account type.
    # @param request The request object with account number, product line and account type to perform a lookup.
    # @return Returns the HTTP response of the GET request.
    def lookup(request)
      get AccountProcessingInformation.lookup(
        request.account_number,
        request.product_line_id,
        request.account_type)
    end
  end
end
