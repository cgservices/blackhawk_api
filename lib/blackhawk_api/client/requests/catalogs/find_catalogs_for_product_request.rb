require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  module Requests
    # Request objects to find catalogs for a product
    class FindCatalogsForProductRequest < PaginatedRequest
      attr_reader :product_id

      def initialize(product_id)
        @product_id = BlackhawkIdentity.new(product_id)
      end
    end
  end
end