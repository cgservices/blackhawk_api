require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  module Requests
    # Request object to retrieve all catalogs
    class GetAllCatalogsRequest < PaginatedRequest
      def initialize
      end
    end
  end
end