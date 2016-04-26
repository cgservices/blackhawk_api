require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  module Requests
    # Request object to find products by product line.
    class FindProductByProductLineRequest < PaginatedRequest
      attr_reader :productline_id

      def initialize(productline_id)
        @productline_id = BlackhawkIdentity.new(productline_id)
      end
    end
  end
end