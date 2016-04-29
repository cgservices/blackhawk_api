require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  module Requests
    # Request object to find products by ids.
    class FindProductsByIdsRequest < PaginatedRequest
      attr_reader :product_ids

      def initialize(ids)
        @product_ids = BlackhawkIdentityArray.new(ids)
      end
    end
    
    class FindProductByIdRequest < Request
      attr_reader :product_id
      
      def initialize(id)
        @product_id = BlackhawkIdentity.new(id)
      end
    end
  end
end