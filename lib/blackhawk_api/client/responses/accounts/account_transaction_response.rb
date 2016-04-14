module BlackhawkApi
  # Response object with account transactions.
  class AccountTransactionResponse < BaseResponse
    attr_reader :entity_id, :creator_id, :updater_id, :notes,
                :created_timestamp, :updated_timestamp, :base_transaction_id,
                :correlation_id, :account_id, :merchant_id, :account_number_last_digits,
                :secondary_account_id, :secondary_account_number, :secondary_account_number_last_digits,
                :currency, :exchange_rate, :requested_amount, :approved_amount,
                :authorization_code, :transaction_response, :resulting_balance,
                :secondary_resulting_balance, :transaction_timestamp, :description,
                :is_void, :is_reversal, :receipt_number, :avs_response_code, :cvv2_response_code,
                :retrieval_reference_number, :first_name, :last_name, :email_address,
                :phone_number, :street, :unit, :city, :country_or_district,
                :state_or_province, :country, :postal_code, :expiration_day,
                :expiration_month, :expiration_year, :device_finger_print_id, :ip_address,
                :store_number, :terminal_number, :offer_details, :receipt_lines,
                :terms_and_conditions, :transaction_type, :payment_processor, :transaction_status,
                :account_type, :payment_network_type, :tax_amount, :transaction_fee, 
                :message_reason_code, :account_number, :activation_account_number,
                :security_code, :additional_redemption_data, :product_id

    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end

    protected

    def parse(object)
      @entity_id = object.entityId
      @creator_id = object.creatorId
      @updater_id = object.updaterId
      @notes = object.notes
      @created_timestamp = object.createdTimestamp
      @updated_timestamp = object.updatedTimestamp
      @base_transaction_id = object.baseTransactionid
      @correlation_id = object.correlationId
      @account_id = object.accountId
      @merchant_id = object.merchantId
      @account_number_last_digits = object.accountNumberLastDigits
      @secondary_account_id = object.secondaryAccountId
      @secondary_account_number = object.secondaryAccountNumber
      @secondary_account_number_last_digits = object.secondaryAccountNumberLastDigits
      @currency = object.currency
      @exchange_rate = object.exchangeRate
      @requested_amount = object.requestedAmount
      @approved_amount = object.approvedAmount
      @authorization_code = object.authorizationCode
      @transaction_response = object.transactionResponse
      @resulting_balance = object.resultingBalance
      @secondary_resulting_balance = object.secondaryResultingBalance
      @transaction_timestamp = object.transactionTimeStamp
      @description = object.description
      @is_void = object.isVoid
      @is_reversal = object.isReversal
      @receipt_number = object.receiptNumber
      @avs_response_code = object.avsResponseCode
      @cvv_response_code = object.cvv2RespnseCode
      @retrieval_reference_number = object.retrievalReferenceNumber
      @first_name = object.firstName
      @last_name = object.lastName
      @email_address = object.emailAddress
      @phone_number = object.phone_number
      @street = object.street
      @unit = object.unit
      @city = object.city
      @country_or_district = object.countryOrDistrict
      @state_or_province = object.stateOrProvince
      @country = object.country
      @postal_code = object.postalCode
      @expiration_month = object.expirationMonth
      @expiration_year = object.expirationYear
      @device_finger_print_id = object.deviceFingerprintId
      @ip_address = object.ipAddress
      @store_number = object.storeNumber
      @terminal_number = object.terminalNumber
      @offer_details = object.offerDetails
      @receipt_lines = object.receiptLines
      @terms_and_conditions = object.termsAndConditions
      @transaction_type = object.transactionType
      @payment_processor = object.paymentProcessor
      @tax_amount = object.taxAmount
      @transaction_fee = object.transactionFee
      @message_reason_code = object.messageReasonCode
      @transaction_status = object.transactionStatus
      @account_type = object.accountType
      @payment_network_type = object.paymentNetworkType
      @company_name = object.companyName
      @account_number = object.account_number
      @activation_account_number = object.activationAccountNumber
      @security_code = object.securityCode
      @expiration_day = object.expirationDay
    end
  end
end
