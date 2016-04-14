require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  # Request object to find products by provisioning type.
  class FindProductByProvisioningTypeRequest < PaginatedRequest
    attr_reader :provisioning_type

    VALID_PROVISIONING_TYPES = [:DIGITAL, :PHYSICAL].freeze

    def initialize(provisioning_type)
      self.provisioning_type = provisioning_type
    end

    protected

    def provisioning_type=(value)
      raise ArgumentError, "Invalid provisioning type #{value}" unless VALID_PROVISIONING_TYPES.include?(value.to_sym)
      @provisioning_type = value
    end
  end
end
