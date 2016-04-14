require 'blackhawk_api/client/client'

module BlackhawkApi
  # Repository for product lines
  class ProductLineRepository < Client
    # This operation retrieves product line information for the specified product line identifier.
    # @param productline_id The identifier of the product line to retrieve information for.
    # @return Returns the HTTP response of the GET request with productline information.
    def find(productline_id)
      get ProductLine.find productline_id
    end

    # This operation retrieves product line summary information associated with the brand identifier.
    # @param request The request object with the brand id for the product line.
    # @return Returns the HTTP response of the GET request with productline information.
    def find_summaries_by_brand(request)
      get ProductLine.find_summaries_by_brand request.brand_id
    end

    # This operation retrieves product line summary information for the given product line identifiers.
    # @param request The request object with identifiers for productlines.
    # @return Returns the HTTP response of the GET request wiht productline summary information.
    def find_summaries_by_ids(request)
      get ProductLine.find_summaries_by_ids request.productline_ids
    end
  end
end
