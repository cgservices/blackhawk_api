require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  class CreateAccountTransactionRequest < Request
    attr_reader :correlation_id, :account_id, :product_id, :merchant_id,
      :account_number_last_digits, :secondary_account_id, :secondary_account_number,
      :secondary_account_number_last_digits, :currency, :exchange_rate, :requested_amount,
      :approved_amount, :authorization_code, :transaction_response, :resulting_balance,
      :secondary_resulting_balance, :transaction_timestamp, :description, :is_void, 
      :receipt_number, :avs_response_code, :cvv2_response_code, :retrieval_reference_number,
      :first_name, :last_name, :email_address, :phone_number, :street, :unit, :city,
      :country_or_district, :state_or_province, :country, :expiration_day, :expiration_month,
      :expiration_year, :device_finger_print_id, :ip_address, :store_number, :terminal_number, 
      :offer_details, :receipt_lines, :terms_and_conditions, :transaction_type, :payment_processor,
      :postal_code, :tax_amount, :transaction_fee, :payment_network_type, :is_reversal, 
      :company_name, :account_number, :activation_account_number, :security_code
    
    def initialize()
    end    
  end
end