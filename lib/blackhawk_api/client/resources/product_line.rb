require "blackhawk_api/version"
require "blackhawk_api/client/base"
require 'httpi'

module BlackhawkApi
  # The Product Line Management API enable the client to retrieve product line information,
  #  that is information about a brand/retailers complete line of products.
  class ProductLine < RESTResource
    @@resource_url = 'productManagement/v1/productLine'
    
    # This API retrieves product line information for the specified product line ID.
    # @param productline_id The internal identifier for the product line.
    # @return Retrieves the requested product line.
    # @raise 404 - attempts.to.retrieve.nonexistent.entity - Nonexistent entity
    def self.find productline_id
      @request = self.setup_request "#{@@resource_url}/#{productline_id}"      
      parse_response HTTPI.get @request
    end
    
    # This API returns ProductLineSummary information about a subset of the product lines
    #  associated with the brand_id in the request.
    # @param brandId The internal identifier for the brand.
    # @return A list of matching ProductLineSummary entities and the total number of entities
    #  existing in the system matching the given brandId.
    def self.find_summaries_by_brand brand_id
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { :brandId => brand_id }      
      parse_response HTTPI.get @request
    end
    
    # This API returns product line summary information for the given product line IDs.
    # @param ids Product Line IDs to be searched.
    # @return A list of matching ProductLineSummary entities and the total number of entities
    #  existing in the system matching the given product line IDs.
    def self.find_summaries_by_ids ids
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { :productLineIds => ids.reject(&:empty).join(';') }      
      parse_response HTTPI.get @request
    end
  end
end