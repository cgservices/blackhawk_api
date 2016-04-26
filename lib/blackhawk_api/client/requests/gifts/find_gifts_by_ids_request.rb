require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  module Requests
    # Request object to query egift entities for the given eGift IDs.
    class FindGiftsByIdsRequest < PaginatedRequest
      attr_reader :gift_ids

      # Creates a new request object.
      # @param egift_ids An array of giftcard identifiers to retrieve.
      def initialize(egift_ids)
        @gift_ids = BlackhawkIdentityArray.new(egift_ids)
      end
    end
  end
end