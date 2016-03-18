require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/requests/blackhawk_identity'

module BlackhawkApi
  # Request object to query egift entities for the given eGift IDs.
  class FindGiftsByIdsRequest < PaginatedRequest
    attr_reader :gift_ids
    
    # Creates a new request object.
    def initialize(egift_ids)
      @gift_ids = BlackhawkIdentityArray.new(egift_ids) 
    end
  end
end