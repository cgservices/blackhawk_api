require 'blackhawk_api/client/errors/api_error'
require 'blackhawk_api/client/responses/product_responses'
require 'json'

module BlackhawkApi
  # Application Service for Product Catalogs.
  class CatalogService < ApplicationService
    # Initializes a new Product Catalog Service.
    # @param catalog_repository The data access for catalogs.
    # @param error_handler An implementation for error handling for this service.
    def initialize(catalog_repository = nil, error_handler = nil)
      super(error_handler)
      @catalogs = catalog_repository || ProductCatalogRepository.new
    end

    # This operation queries all product catalog summaries
    # @param request
    # @return
    def all(request = nil)
      web_response, _results = perform request do
        @catalogs.all(request)
      end
      Responses::ProductCatalogsResponse.new(web_response)
    end

    # def all_(request = nil)
    #   web_response, _results = perform request do
    #     ProductCatalog.all(request)
    #   end
    #   Responses::ProductCatalogsResponse.new(web_response)
    # end

    # This operation retrieves the version for a specified product catalog identifier.
    # @param catalog_id The identifier of the catalog.
    # @return
    def get_version(catalog_id)
      web_response = @catalogs.get_version catalog_id
      Responses::ProductCatalogVersionResponse.new(web_response)
    end

    # This operation reads product catalog information based on a specified product catalog identifier.
    # @param catalog_id The internal identifier of the product catalog.
    # @return
    def find(catalog_id)
      request = Requests::FindCatalogByIdRequest.new(catalog_id)
      web_response, _results = perform request do
        @catalogs.find(request.catalog_id)
      end
      Responses::ProductCatalogDetailsResponse.new(web_response)
    end

    # This operation queries the name from product catalog summary information for a catalog.
    # @param request
    # @return
    def find_by_name(request)
      web_response, _results = perform request do
        @catalogs.find_by_name(request)
      end
      Responses::ProductCatalogsResponse.new(web_response)
    end

    # This operation queries product catalog summary information by catalog Ids.
    # @param request
    # @return
    def find_by_ids(request)
      web_response, _results = perform request do
        @catalogs.find_by_ids(request)
      end
      Responses::ProductCatalogsResponse.new(web_response)
    end

    # This operation returns a list of summaries for a given product ID from a catalog.
    # @param request
    # @return
    def find_product_catalogs_for_product(request)
      web_response, _results = perform request do
        @catalogs.find_product_catalogs_for_product(request)
      end
      Responses::ProductCatalogsResponse.new(web_response)
    end
  end
end
