require "blackhawk_api/version"
require "blackhawk_api/client/errors/blackhawk_api_error"
require "blackhawk_api/client/responses/product_response"
require "blackhawk_api/client/base"
require "blackhawk_api/client/services/service_base"
require 'json'

module BlackhawkApi
  # Application Service for Product Catalogs.
  class CatalogService < BlackhawkService
    # Initializes a new Product Catalog Service.
    # @param catalog_repository The data access for catalogs.
    # @param error_handler An implementation for error handling for this service.
    def initialize(catalog_repository = nil, error_handler = nil)
      super(error_handler)
      @catalogs = catalog_repository ||= ProductCatalogRepository.new
    end    
    
    # This operation queries all product catalog summaries
    # @param request
    # @return
    def all request
      perform request do
        @catalogs.all(request)
      end
    end
    
    # This operation reads product catalog information based on a specified product catalog identifier.
    # @param catalog_id The internal identifier of the product catalog.
    # @return
    def find catalog_id
      @catalogs.find catalog_id
    end
    
    # This operation queries the name from product catalog summary information for a catalog.
    # @param request
    # @return
    def find_by_name request
      perform request do
        @catalogs.find_by_name(request)
      end
    end
    
    # This operation queries product catalog summary information by catalog Ids.
    # @param request
    # @return
    def find_by_ids request
      perform request do
        @catalogs.find_by_ids(request)
      end
    end
    
    # This operation returns a list of summaries for a given product ID from a catalog.
    # @param request
    # @return
    def find_product_catalogs_for_product request
      perform request do
        @catalogs.find_product_catalogs_for_product(request)
      end
    end
    
    # This operation retrieves the version for a specified product catalog identifier.
    # @param request
    # @return
    def get_version catalog_id
      return @catalogs.get_version catalog_id
    end
    
    protected
    def perform request, &block
      return if !validate request

      response = yield
      return inspected response
    end
    
    private
    def as_product_catalog_response result
      return ProductCatalogResponse.new(result.total, result.parameters)
    end
    
    def as_product_catalog_summary_response result
      # TODO: Implementation
      raise :NotImplementedError
    end
  end
end