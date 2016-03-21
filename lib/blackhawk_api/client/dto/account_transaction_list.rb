module BlackhawkApi
  class AccountTransactionList
    attr_reader :entity_id, :creator_id, :updater_id, :created_timestamp,
      :updated_timestamp, :account_id, :merchant_id, :account_type,
      :transaction_type, :transaction_status, :account_number_last_digits,
      :currency, :requested_amount, :approved_amount, :authorization_code,
      :transaction_response, :transaction_timestamp, :description,
      :is_void
      
    def initialize(transaction_data)
      @entity_id = transaction_data.entityId
      @creator_id = transaction_data.creatorId
      @updater_id = transaction_data.updaterId
      @created_timestamp = transaction_data.createdTimestamp
      @updatedTimestamp = transaction_data.updatedTimestamp
      @account_id = transaction_data.accountId
      @merchant_id = transaction_data.merchantId
      @account_type = transaction_data.accountType
      @transaction_type = transaction_data.transactionType
      @transaction_status = transaction_data.transactionStatus
      @account_number_last_digits = transaction_data.accountNumberLastDigits
      @currency = transaction_data.currency
      @requested_amount = transaction_data.requestedAmount
      @approved_amount = transaction_data.approvedAmount
      @authorization_code = transaction_data.authorizationCode
      @transaction_response = transaction_data.transactionResponse
      @transaction_timestamp = transaction_data.transactionTimeStamp
      @description = transaction_data.description
      @is_void = transaction_data.isVoid
    end
  end
end