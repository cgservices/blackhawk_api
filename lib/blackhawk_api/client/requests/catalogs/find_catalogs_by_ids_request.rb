require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  module Requests
    # Find catalogs by one or more identification numbers.
    class FindCatalogsByIdsRequest < PaginatedRequest
      attr_reader :catalog_ids

      def initialize(catalog_ids)
        @catalog_ids = BlackhawkIdentityArray.new(catalog_ids)
      end
    end
    
    # Find catalog by id.
    class FindCatalogByIdRequest < Request
      attr_reader :catalog_id
       
      def initialize(catalog_id)
        @catalog_id = BlackhawkIdentity.new(catalog_id)
      end
    end
  end
end