require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/requests/blackhawk_identity'

module BlackhawkApi
  class FindProductByProductLineRequest < PaginatedRequest
    attr_reader :productline_id

    def initialize(productline_id)
      @productline_id = BlackhawkIdentity.new(productline_id)
    end
  end
end