require 'blackhawk_api/version'
require 'blackhawk_api/client/base'
require 'httpi'
require 'json'

module BlackhawkApi
  # The Account Processing API enable consumers to acquire cards from distributors and perform transactions using them.
  #  When consumers purchase cards from distributors, Account Processing takes care of setting up the card
  #  with its unique identifying number (or BIN, Bank Identification Number).
  #  Additionaly, Account Processing enables card owners to look up card balance and redeem and reload the card.
  class AccountProcessingInformation < RESTResource
    @@resource_url = 'accountProcessing/v1'

    # This operation is used to get an account number for the given product and amount.
    def self.create(product_id, amount, currency, transaction_time, reference_number,
                    store_number, terminal_number, base_transaction_id, message_reason_code)

      @request = setup_request "#{@@resource_url}/createAccount"
      hash = {
        productId: product_id, amount: amount, currency: currency,
        transactionTime: transaction_time, retrievalReferenceNumber: reference_number,
        storeNumber: store_number, terminalNumber: terminal_number,
        baseTransactionId: base_transaction_id, messageReasonCode: message_reason_code 
      }
      @request.body = hash.to_json
      @request
    end

    # This operation uses an accountId to retrieve account information. This operation can be 
    # used instead of find_with_balance if the current balance is not required.
    # @param account_id The internal identifier of an account.
    # @return Retrieves the requested account information.
    # @raise 400 - accountId.null - Account ID is null in request
    # @raise 409 - account.does.not.exist - No account found for account ID
    def self.find(account_id)
      @request = setup_request "#{@@resource_url}/readAccount"
      @request.query = { accountId: account_id }
      @request
    end

    # This operation uses an accountId to retrieve account information, including the current balance.
    # Updates are reflected in the current balance.
    # @param account_id The internal identifier of an account.
    # @return Retrieves the requested account information, including the current balance.
    # @raise 400 - bhn.com.service.request.missing.parameter - Account ID missing in request
    # @raise 400 - com.bhn.general.invalid.argument - Illegal argument supplied in the request
    # @raise 400 - header.contractId.blank - contractId header is blank
    # @raise 409 - account.does.not.exist - No account found for account ID
    # @raise 409 - productline.not.found - Product line not found in the system
    # @raise 409 - product.not.found - Product ID associated to the product line is not found in the system
    # @raise 409 - balance.inquiry.not.supported - The product line passed in the request does not support balance inquiry
    # @raise 400 - invalid.contract.id - Invalid contractId
    def self.find_with_balance(account_id)
      @request = setup_request "#{@@resource_url}/getAccount"
      @request.query = { accountId: account_id }
      @request
    end

    # This operation queries an account using Account Number, Product Line ID and Account Type.
    # If the account is not found, it returns no content.
    # @param account_number Account number of the account.
    # @param product_line_id Internal identifier of the product line.
    # @param account_type Type of the account.
    def self.lookup(account_number, product_line_id, account_type)
      @request = setup_request "#{@@resource_url}/lookupAccount"
      @request.query = {
        accountNumber: account_number,
        productLineId: product_line_id,
        accountType: account_type
      }
      @request
    end
    
    # This operation is used to reverse an account transaction. When the client did not receive the response (timeout)
    # because of various reasons, the client sends the reversal using this operation.
    # @param reversal_transaction_request_id This is the ID used for idempotency of the original transaction.
    # @raise 400 - bhn.com.service.request.missing.parameter
    # @raise 400 - account.reversalTxnRequestId.blank
    # @raise 409 - accountTransaction.not.found
    # @raise 409 - account.does.not.exist
    # @raise 409 - max.reversal.time.elapsed
    # @raise 409 - original.transaction.not.found
    # @raise 409 - account.unsupported.transaction.type
    # @raise 409 - secondary.account.missing
    def self.reverse(reversal_transaction_request_id)
      @request = setup_request "#{@@resource_url}/reverseTransaction"
      @request.query = {
        reversalTxnRequestId: reversal_transaction_request_id
      }
      @request
    end
  end
end
