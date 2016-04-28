require 'blackhawk_api/version'
require 'blackhawk_api/client/base'
require 'blackhawk_api/client/errors/api_error'
require 'blackhawk_api/client/responses/product_responses'
require 'json'
require 'blackhawk_api/client/services/service_base'

module BlackhawkApi
  # Application Service for Products.
  class ProductService < ApplicationService
    # Initializes a new Product Service.
    # @param product_repository The data access for products.
    # @param error_handler An implementation for error handling for this service.
    def initialize(product_repository = nil, error_handler = nil)
      super(error_handler)
      @products = product_repository || ProductRepository.new
    end

    # Retrieve product information for the specified product_id.
    # @param product_id The internal identifier for the product.
    # @return Retrieves the requested product.
    def find(product_id)
      Responses::ProductDetailsResponse.new(@products.find(product_id))
    end

    # Retrieve a list of product summary entities matching the given search keyword.
    # @param request The FindProductByKeywordRequest
    # @return Retrieves a list of matching product summary entities and the total count returned
    #  from the query and the request elements specified in the request.
    def find_by_keyword(request)
      web_response, results = perform request do
        @products.find_by_keyword(request)
      end
      Responses::ProductResponse.new(web_response)
    end

    # This operation returns a list of summary information for the subset of products matching
    #  the given provisioning type.
    # @param request The FindProductByProvisioningTypeRequest
    # @return Retrieves a list of product summary entities and the total number of entities
    #  existing in the system matching the given provisioning type.
    def find_by_provisioning_type(request, index, size)
      web_response, results = perform request do
        return @products.find_by_provisioning_type(request, index, size)
      end
      Responses::ProductResponse.new(web_response)
    end

    # Retrieve a list of summary information about a subset of the products matching a given product_line_id
    # @param request The FindProductsByProductLineRequest
    # @return Retrieves a list of matching product summary entities and the total number of entities
    # existing in the system matching the given product line ID.
    def find_by_productline(request)
      web_response, results = perform request do
        @products.find_by_productline(request)
      end
      Responses::ProductResponse.new(web_response)
    end

    # Retrieves a list of product summary information for the given product IDs.
    # @param request The FindProductsByIdsRequest
    # @return Retrieves a list of matching product summary entities and the total number of entities
    #  existing in the system matching the given product IDs.
    def find_by_ids(request)
      web_response, results = perform request do
        @products.find_by_ids(request)
      end
      Responses::ProductResponse.new(web_response)
    end

    # Retrieves a list of product summary information for the given product configuration ID.
    # @param request The FindProductByConfigurationRequest
    # @return Retrieves a list of product summary entities and the total number of entities existing
    # in the sustem matching the given configuration ID.
    def find_by_configuration(request)
      web_response, results = perform request do
        @products.find_by_configuration(request)
      end
      Responses::ProductResponse.new(web_response)
    end
  end
end
