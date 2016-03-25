require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  class GetCatalogVersionRequest < PaginatedRequest
    attr_reader :catalog_id
    
    def initialize(catalog_id)
      @catalog_id = BlackhawkIdentity.new(catalog_id)
    end
  end
end