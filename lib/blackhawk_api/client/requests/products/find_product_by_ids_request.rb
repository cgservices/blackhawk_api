require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/requests/blackhawk_identity'


module BlackhawkApi
  class FindProductsByIdsRequest < PaginatedRequest
    attr_reader :product_ids
    
    def initialize(ids)
      @product_ids = BlackhawkIdentityArray.new(ids)
    end
  end
end