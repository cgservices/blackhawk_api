module BlackhawkApi
  class AccountTransaction
    attr_reader :entity_id, :creator_id, :updater_id, :notes,
      :created_timestamp, :updated_timestamp, :base_transaction_id,
      :correlation_id, :account_id, :merchant_id, :account_number_last_digits,
      :secondary_account_id, :secondary_account_number, :secondary_account_number_last_digits,
      :currency, :exchange_rate, :requested_amount, :approved_amount, :authorization_code,
      :transaction_response, :resulting_balance, :secondary_resulting_balance,
      :transaction_timestamp, :description, :is_void, :is_reversal, :receipt_number,
      :avs_response_code, :cvv2_response_code, :retrieval_reference_number, :first_name,
      :last_name, :email_address, :phone_number, :street, :unit, :city, :country_or_district,
      :state_or_province, :country, :postal_code, :expiration_day, :expiration_month, 
      :expiration_year, :device_finger_print_id, :ip_address, :store_number, :terminal_number,
      :offer_details, :receipt_lines, :terms_and_conditions, :transaction_type, :payment_processor,
      :transaction_status, :account_type, :payment_network_type, :tax_amount, :transaction_fee,
      :message_reason_code, :account_number, :activation_account_number, :security_code,
      :additional_redemption_data, :product_id
      
    def initialize(transaction_info)
      @entity_id = transaction_info
    end
  end
end