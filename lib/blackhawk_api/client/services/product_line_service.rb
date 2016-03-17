require "blackhawk_api/client/services/service_base"

module BlackhawkApi
  class ProductLineService < BlackhawkService
    # Initializes a new ProductLine Service.
    # @param productline_repository The data access for productlines.
    # @param error_handler An implementation for error handling for this service.
    def initialize(productline_repository = nil, error_handler = nil)
      super(error_handler)
      @productlines = productline_repository ||= ProductLineRepository.new
    end
    
    # This operation retrieves product line information for the specified product line ID.
    # @param productline_id The internal identifier for the product line.
    # @return Retrieves the requested productline
    def find productline_id
      @productlines.find productline_id
    end
    
    # This operation retrieves product line summary information about a subset of the product lines
    # associated with the brand_id in the request.
    # @param request
    # @return
    def find_summaries_by_brand request
      perform request do
        @productlines.find_summaries_by_brand request
      end
    end
    
    # This operation returns product line summary information for the given product line IDs.
    # @param request
    # @return
    def find_summaries_by_ids request
      perform request do
        @productlines.find_summaries_by_ids request
      end
    end
    
    protected
    def perform request, &block
      return if !validate request

      response = yield
      return inspected response
    end
  end
end