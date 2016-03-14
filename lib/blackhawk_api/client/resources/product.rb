require "blackhawk_api/version"
require "blackhawk_api/client/base"
require 'httpi'

module BlackhawkApi
  # The Product Management API enables client applications to work with information about individual products.
  # In functionality that enables selling of cards, you application calls the Product Management Service to
  # provide customers information about specific products in your catalog.
  class Product < RESTResource
    @@resource_url = 'productManagement/v1/product'
    
    # This API retrieves product information for the specified product_id.
    # @param product_id The internal identifier for the product.
    # @return Retrieves the requested product.
    # @raise 404 - attempt.to.retrieve.nonexistent.entity - Nonexistent entity
    def self.find product_id
      @request = self.setup_request "#{@@resource_url}/#{product_id}"
      parse_response HTTPI.get @request
    end
    
    # This API retrieves a list of summary information about a subset of the products
    #  matching a given product line ID.
    # @param productline_id The internal identifier for the product line.
    # @return Retrieves a list of matching product summary entities and the total number of 
    #  entities existing in the system matching the given product line ID.
    def self.find_by_productline(productline_id)
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { :productLineId => productline_id }
      parse_response HTTPI.get @request
    end
    
    # This API returns a list of product summary information for the given product IDs.
    # @param ids The Product IDs to be searched.
    # @return Retrieves a list of matching product summary entities and the total number of 
    #  entities existing in the system matching the given product IDs.
    def self.find_by_ids ids
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { :productIds => ids.reject(&:empty).join(';') }
      parse_response HTTPI.get @request
    end
    
    # This API returns a list of product summary entities matching the given search keyword.
    # @param keyword Search keyword.
    # @param exact_match Flag to exactly match the given criteria, the default is true.
    # @param case_sensistive Flag to exactly match the case of the given criteria, the default is true.
    # @param sortKey The name of the attribute that should be used for ordering the results.
    # @param ascending Whether or not the results are sorted in ascending order.
    # @param first The index of the first entity in this cursor view of the list. The default first index is zero referring to the first entity in the full list.
    # @param maximum The maximum number of entities to be shown in this cursor view of the list.
    # @return Retrieves a list of matching product summary entities and the total count returned from the query and the request elements specified in the request.
    def self.find_by_keyword (keyword, exact_match = true, 
      case_sensistive = true, sortKey = :productName, ascending = true, first = 0, maximum = 100)
      
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = {
        :keyword => keyword, :exactMatch => exact_match, :caseSensistive => case_sensistive,
        :sortKey => sortkey, :ascending => ascending, :first => first, :maximum => maximum
      }
      parse_response HTTPI.get @request
    end
    
    # This operation returns a list of summary information about a subset
    #  of the products matching a given product configuration ID.
    # @param configuration_id The internal identifier for the product configuration.
    # @return Retrieves a list of ProductSummary entities and the total number of entities
    #  existing in the system matching the given configuration ID.
    def self.find_by_configuration configuration_id
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { :configurationId => configuration_id }
      parse_response HTTPI.get @request
    end
    
    # This operation returns a list of summary information for the subset of products
    #  matching a given provisioning type.
    # @param provisioning_type PHYSICAL or DIGITAL
    # @return Retrieves a list of ProductSummary entities and the total number of entities
    #  ecisting in the system matching the given provisioning type.
    def self.find_by_provisioning_type provisioning_type
      @request = self.setup_request "#{@@resource_url}s"
      query = { :provisioningType => provisioning_type }
      @request.query = self.default_pagination.merge(query)      
      parse_response HTTPI.get @request
    end
  end
end