require 'blackhawk_api/version'
require 'blackhawk_api/client/base'
require 'httpi'

module BlackhawkApi
  # The Product Catalog Management API enables client applications to get details of the catalog of products that they sell.
  # In functionality that enables selling of cards, the application calls the Product Catalog Management Service to provide
  # the information about your catalog that customers need to make a purchasing decision.
  class ProductCatalog < RESTResource
    @@resource_url = 'productCatalogManagement/v1/productCatalog'

    # This operation queries all product catalog summaries.
    # @return List of product catalog summary with the total number of product catalog summaries existing in the system.
    def self.all(request)
      self.setup_request "#{@@resource_url}s"
    end

    # This operation reads product catalog information based on a specified product catalog identifier.
    # @param catalog_id The internal identifier of the product catalog.
    # @return Retrieves the ProductCatalog for the given catalog_id.
    # @raise 404 - attempts.to.retrieve.nonexistent.entity - Nonexistent entity.
    def self.find(catalog_id)
      self.setup_request "#{@@resource_url}/#{catalog_id}"
    end

    # This operation queries product catalog summary information for a catalog by name.
    # @param catalog_name The name of the product catalog.
    # @return Retrieves a list of matching ProductCatalogSummary and the total number of entities
    #  existing in the system matching the given catalog name.
    def self.find_by_name(catalog_name)
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { catalogName: catalog_name }
      @request
    end

    # This operation queries product catalog summary information by catalog IDs.
    # @param catalog_ids The external identifiers for the catalogs.
    # @return Retrieves a list of matching ProductCatalogSummary and the total number of entities
    #  matching the given catalog IDs.
    def self.find_by_ids(catalog_ids)
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { catalogIds: catalog_ids.to_s }
      @request
    end

    # This API returns a list of summaries for a given product ID from a catalog.
    # @param product_id The internal identifier of the product.
    # @return Retrieves a list of ProductCatalogSummary matching the given product_id.
    def self.find_product_catalogs_for_product(product_id)
      @request = self.setup_request "#{@@resource_url}s"
      @request.query = { productId: product_id }
      @request
    end

    # This operation retrieves the version for a specified product catalog identifier.
    # @param catalog_id The internal identifier of the product catalog.
    # @raise 403 - query.all.product.catalogs.by.product.unauthorized - Not authorized.
    def self.get_version(catalog_id)
      self.setup_request "#{@@resource_url}/#{catalog_id}/version"
    end
  end
end
