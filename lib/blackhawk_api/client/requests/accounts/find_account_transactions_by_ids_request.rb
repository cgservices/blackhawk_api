require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  module Requests
    # Request object to find account transactions by id.
    class FindAccountTransactionsByIdsRequest < PaginatedRequest
      attr_reader :transaction_ids

      def initialize(transaction_ids)
        @transaction_ids = BlackhawkIdentityArray.new(transaction_ids)
      end
    end
  end
end