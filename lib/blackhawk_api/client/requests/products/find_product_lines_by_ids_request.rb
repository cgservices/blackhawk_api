require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  # Request object to find product lines by provided ids.
  class FindProductLinesByIdsRequest < PaginatedRequest
    attr_reader :productline_ids

    def initialize(productline_ids)
      @productline_ids = BlackhawkIdentityArray.new(productline_ids)
    end
  end
end
