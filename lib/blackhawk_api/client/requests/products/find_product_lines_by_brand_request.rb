require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/values/blackhawk_identity'

module BlackhawkApi
  # Request object to find productlines by brand
  class FindProductLinesByBrandRequest < PaginatedRequest
    attr_reader :brand_id

    def initialize(brand_id)
      @brand_id = BlackhawkIdentity.new(brand_id)
    end
  end
end
