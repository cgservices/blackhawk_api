require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  
  class FindProductByProvisioningTypeRequest < PaginatedRequest
    attr_reader :provisioning_type
    
    VALID_PROVISIONING_TYPES = [:DIGITAL, :PHYSICAL]
    
    def initialize(provisioning_type)      
      self.provisioning_type = provisioning_type
    end
    
    protected
    def provisioning_type=(value)
      raise ArgumentError, "Invalid provisioning type #{value.to_s}" unless VALID_PROVISIONING_TYPES.include?(value.to_sym)
      @provisioning_type = value
    end
  end
end