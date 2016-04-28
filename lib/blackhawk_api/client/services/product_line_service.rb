require 'blackhawk_api/client/services/service_base'

module BlackhawkApi
  # Application Service for Product Lines.
  class ProductLineService < ApplicationService
    # Initializes a new ProductLine Service.
    # @param productline_repository The data access for productlines.
    # @param error_handler An implementation for error handling for this service.
    def initialize(productline_repository = nil, error_handler = nil)
      super(error_handler)
      @productlines = productline_repository || ProductLineRepository.new
    end

    # This operation retrieves product line information for the specified product line ID.
    # @param productline_id The internal identifier for the product line.
    # @return Retrieves the requested productline
    def find(productline_id)
      result = @productlines.find productline_id
      Responses::ProductLineDetailsResponse.new(result)
    end

    # This operation retrieves product line summary information about a subset of the product lines
    # associated with the brand_id in the request.
    # @param request
    # @return
    def find_summaries_by_brand(request)
      web_response, results = perform request do
        @productlines.find_summaries_by_brand request
      end
      Responses::ProductLinesResponse.new(web_response)
    end

    # This operation returns product line summary information for the given product line IDs.
    # @param request
    # @return
    def find_summaries_by_ids(request)
      web_response, results = perform request do
        @productlines.find_summaries_by_ids request
      end
      Responses::ProductLinesResponse.new(web_response)
    end
  end
end
