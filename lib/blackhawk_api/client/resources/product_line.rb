module BlackhawkApi
  # The Product Line Management API enable the client to retrieve product line information,
  #  that is information about a brand/retailers complete line of products.
  class ProductLine < RESTResource
    @@resource_url = 'productManagement/v1/productLine'

    def initialize(config)
      super(config)
    end

    # This API retrieves product line information for the specified product line ID.
    # @param productline_id The internal identifier for the product line.
    # @return Retrieves the requested product line.
    # @raise 404 - attempts.to.retrieve.nonexistent.entity - Nonexistent entity
    def find(productline_id)
      setup_request "#{@@resource_url}/#{productline_id}"
    end

    # This API returns ProductLineSummary information about a subset of the product lines
    #  associated with the brand_id in the request.
    # @param brand_id The internal identifier for the brand.
    # @return A list of matching ProductLineSummary entities and the total number of entities
    #  existing in the system matching the given brandId.
    def find_summaries_by_brand(brand_id)
      @request = setup_request "#{@@resource_url}s"
      @request.query = { brandId: brand_id }
      @request
    end

    # This API returns product line summary information for the given product line IDs.
    # @param ids Product Line IDs to be searched.
    # @return A list of matching ProductLineSummary entities and the total number of entities
    #  existing in the system matching the given product line IDs.
    def find_summaries_by_ids(ids)
      @request = setup_request "#{@@resource_url}s"
      @request.query = { productLineIds: ids.to_s }
      @request
    end
  end
end
