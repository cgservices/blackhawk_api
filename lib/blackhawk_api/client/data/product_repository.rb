require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'
require 'pry'

module BlackhawkApi
  class ProductRepository < Client    
    # This operation retrieves product information for the specified product identifier.
    def find product_id
      get Product.find product_id
    end
    
    # This operation returns a list of product summary information for the subset of products
    # matching a given provisioning type.
    def find_by_provisioning_type request
      get Product.find_by_provisioning_type(request.provisioning_type)
    end
    
    # This operation returns a list of product summary entitities matching the given search keyword.
    def find_by_keyword request
      get Product.find_by_keyword(request.keyword)
    end
    
    # This operation retrieves a list of product summary information about a subset of the products 
    # matching a given product line ID.
    def find_by_productline request
      get Product.find_by_productline request.productline_id
    end
    
    # This operation returns a list of product summary information for the given product identifiers.
    def find_by_ids request
      get Product.find_by_ids (request.product_ids.to_s)
    end
    
    # This operation returns a list of product summary information for the given configuration ID. 
    def find_by_configuration request
      get Product.find_by_configuration(request.configuration_id)
    end
  end
end