require "blackhawk_api/version"
require "blackhawk_api/client/base"
require 'httpi'

module BlackhawkApi
  # The Account Transaction Management API operations enables a client to create, read, correlate and query account transactions.
  class AccountTransaction < RESTResource
    @@correlation_url = 'accountTxnManagement/v1'
    @@resource_url = 'accountTxnManagement/v1/accountTransaction'
    
    # This operation creates an account transaction
    # @param account_transaction The account transaction to be created.
    # @return The newly created Account Transaction.
    # @raise 400 - account.txn.merchantId.blank - Merchant Id involved in this transaction is blank
    # TODO: Update errors -> https://developer.blackhawknetwork.com/documentation/apiReference/Service+-+Account+Transaction+Management/Operation+-+Create+Account+Transaction 
    def self.create account_transaction
      @request = self.setup_request "#{@@resource_url}"
      @request.body = account_transaction.to_json
      parse_response HTTPI.post @request
    end
    
    # This operation retrieves full account transaction information for the specified account transaction identifier.
    # @param account_transaction_id The internal identifier of the account transaction.
    # @return Retrieves the requested account transaction.
    # @raise 404 - EntityNotFoundException - The requested entity is not found by the service
    def self.find account_transaction_id
      @request = self.setup_request "#{@@resource_url}/#{account_transaction_id}"
      parse_response HTTPI.get @request
    end
    
    # This operation queries account transactions by transaction ids.
    # @param transaction_ids The internal identifier of an Account Transaction.
    # @return Retrieves a list of matching Account Transaction entities and the total number of entities matching the account
    #  transaction ID.
    def self.find_by_ids transaction_ids
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { :accountTransactionIds => transaction_ids.reject(&:empty).join(';') }
      parse_response HTTPI.get @request
    end
    
    # This operation queries account transactions associated with the given account ID.
    # @param account_id The internal identifier of an Account.
    # @return Retrieves a list of matching Account Transaction entities and the total number of entities matching the account
    #  transaction ID.
    def self.find_by_account_id account_id
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { :accountId => account_id }
      parse_response HTTPI.get @request
    end
    
    # This operation queries account transactions associated with the given correlation ID.
    # @param correlation_id The grouping ID of Account Transactions.
    # @return Retrieves a list of matching Account Transaction entities and the total number of entities matching the account
    #  transaction ID.
    def self.find_by_correlation_id correlation_id
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { :correlationId => correlation_id }
      parse_response HTTPI.get @request
    end
    
    # This operation groups a set of account transactions using a correlation ID.
    # @param transaction_ids The list of account transaction ids to be grouped.
    # @return Returns a correlation ID.
    # @raise 400 - ids.to.correlate.null - GUIDs to correlate is null
    # @raise 400 - atleast.two.guids.needed.to.correlate - GUIDs to correlate is not enough
    def self.correlate transaction_ids
      @request = self.setup_request "#{@@correlation_url}/correlate"
      parse_response HTTPI.put @request
    end
  end
end