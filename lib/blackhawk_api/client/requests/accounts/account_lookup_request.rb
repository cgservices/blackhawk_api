require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/enumerations'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  # Request object for the account lookup call.
  class AccountLookupRequest < Request
    attr_reader :account_number, :product_line_id, :account_type

    def initialize(account_number, product_line_id, account_type)
      self.account_number = account_number
      self.account_type = account_type
      @product_line_id = BlackhawkIdentity.new(product_line_id)
    end

    protected

    def account_number=(value)
      raise ArgumentError, 'No account number specified' if value.nil? || value.empty?
      raise ArgumentError, "Account number too large (#{value}).length > 255" if value.length > 255
      @account_number = value
    end

    def account_type=(value)
      raise ArgumentError, "Invalid account type (#{value})" unless Enums::VALID_ACCOUNT_TYPES.include?(value.to_sym)
      raise ArgumentError, "Unsupported account type (#{value})" unless Enums::SUPPORTED_ACCOUNT_TYPES.include?(value.to_sym)
      @account_type = value
    end
  end
end
