module BlackhawkApi
  class AccountInformation
    attr_reader :entity_id, :updated_timestamp, :type, :account_number,
      :security_code, :product_line_id, :product_id, :balance,
      :balance_as_of, :is_balance_stale, :currency, :activation_account_number,
      :activation_amount, :activation_timestamp, :activation_location,
      :expiration_day, :expiration_month, :expiration_year, :additional_redemption_data, 
      :status, :bar_code_value, :balance_response
      
    def initialize(account_data)
      @entity_id = account_data.entityId
      @updated_timestamp = account_data.updatedTimestamp
      @type = account_data.type
      @account_number = account_data.accountNumber
      @activation_account_number = account_data.activationAccountNumber
      @security_code = account_data.securityCode
      @product_line_id = account_data.productLineId
      @product_id = account_data.productId
      @balance = account_data.balance
      @balance_as_of = account_data.balance_as_of
      @is_balance_stale = account_data.isBalanceStale
      @currency = account_data.currency
      @activation_amount = account_data.activationAmount
      @status = account_data.status
      @expiration_month = account_data.expirationMonth
      @expiration_year = account_data.expirationYear
      @expiration_day = account_data.expirationDay
    end
  end
end