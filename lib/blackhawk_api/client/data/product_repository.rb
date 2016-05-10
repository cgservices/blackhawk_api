require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'

module BlackhawkApi
  # Repository class for products.
  class ProductRepository < Client
    # This operation retrieves product information for the specified product identifier.
    # @param product_id The identifier of the product.
    # @return Returns the HTTP response of the GET request with product information.
    def find(product_id, &block)
      http_request = Product.find product_id do |request|
        request = yield request if block_given?
        request
      end
      get http_request
    end

    # This operation returns a list of product summary information for the subset of products
    # matching a given provisioning type.
    # @param request The request object with the requested provisioning type.
    # @return Returns the HTTP response of the GET request with product information.
    def find_by_provisioning_type(request, index = 0, size = 10)
      get Product.find_by_provisioning_type(request.provisioning_type, index, size)
    end

    # This operation returns a list of product summary entitities matching the given search keyword.
    # @param request The request object with keywords to search for.
    # @return Returns the HTTP response of the GET request with product information.
    def find_by_keyword(request)
      get Product.find_by_keyword(request.keyword)
    end

    # This operation retrieves a list of product summary information about a subset of the products 
    # matching a given product line ID.
    # @param request The request object with the product line identifier to retrieve products for.
    # @return Returns the HTTP response of the GET request with products subject to given product line.
    def find_by_productline(request)
      get Product.find_by_productline request.productline_id
    end

    # This operation returns a list of product summary information for the given product identifiers.
    # @param request The request object with the product identifiers to retrieve.
    # @return Returns the HTTP response of the GET request with products matching the given product ids.
    def find_by_ids(request)
      get Product.find_by_ids request.product_ids.to_s
    end

    # This operation returns a list of product summary information for the given configuration ID.
    # @param request The request object with the identifier of the configuration to retrieve products for.
    # @return Returns the HTTP response of the GET request with products matching given configuration.
    def find_by_configuration(request)
      get Product.find_by_configuration(request.configuration_id)
    end
  end
end
