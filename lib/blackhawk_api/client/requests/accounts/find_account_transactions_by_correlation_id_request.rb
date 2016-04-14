require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  # Request object to find transactions by correlation id.
  class FindAccountTransactionsByCorrelationIdRequest < PaginatedRequest
    attr_reader :correlation_id

    def initialize(correlation_id)
      @correlation_id = BlackhawkIdentity.new(correlation_id)
    end
  end
end
