require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  # Request object to find products by configuration
  class FindProductByConfigurationRequest < PaginatedRequest
    attr_reader :configuration_id

    def initialize(configuration_id)
      @configuration_id = BlackhawkIdentity.new(configuration_id)
    end
  end
end
