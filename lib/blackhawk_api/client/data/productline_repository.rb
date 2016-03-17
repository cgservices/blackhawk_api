require 'blackhawk_api/client/client'

module BlackhawkApi
  class ProductLineRepository < Client
    # This operation retrieves product line information for the specified product line identifier.
    def find productline_id
      get ProductLine.find productline_id
    end
      
    # This operation retrieves product line summary information associated with the brand identifier.
    def find_summaries_by_brand request
      get ProductLine.find_summaries_by_brand request.brand_id
    end
    
    # This operation retrieves product line summary information for the given product line identifiers.
    def find_summaries_by_ids request
      get ProductLine.find_summaries_by_ids request.productline_ids
    end
  end
end