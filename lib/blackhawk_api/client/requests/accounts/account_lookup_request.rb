require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  class AccountLookupRequest < Request
    attr_reader :account_number, :product_line_id, :account_type
    
    VALID_ACCOUNT_TYPES = [:CREDIT_CARD, :GIFT_CARD, :LOYALTY_CARD, :PHONE_CARD]
    
    def initialize(account_number, product_line_id, account_type)
        self.account_number = account_number
        self.account_type = account_type
        @product_line_id = BlackhawkIdentity.new(product_line_id)
    end
    
    protected
    def account_number=(value)
      raise ArgumentError, "No account number specified (#{value})" if value.nil? || value.length == 0
      raise ArgumentError, "Account number too large (#{value})" if value.length > 255
      @account_number = value
    end
    
    def account_type=(value)
      raise ArgumentError, "Invalid account type #{value.to_s}" unless VALID_ACCOUNT_TYPES.include?(value.to_sym)
    end
  end
end