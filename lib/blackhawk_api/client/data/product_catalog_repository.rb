require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'
require 'json'

module BlackhawkApi
  # Repository for product catalogs.
  class ProductCatalogRepository < Client
    # This operation queries all product catalog summaries.
    # @param request The request object to get all product catalogs.
    # @return Returns the HTTP response of the GET request with all catalogs.
    def all(request)
      get ProductCatalog.all request
    end

    # This operation reads product catalog information based on a specified product catalog identifier.
    # @param catalog_id The identifier for the catalog to get more information about.
    # @return Returns the HTTP response of the GET request with details about the specified catalog.
    def find(catalog_id)
      get ProductCatalog.find catalog_id
    end

    # This operation queries product catalog summaries for a catalog by name.
    # @param request The request object with the name of the catalog to find.
    # @return Returns the HTTP response of the GET request with details about the specified catalog.
    def find_by_name(request)
      get ProductCatalog.find_by_name(request.name)
    end

    # This operation queries product catalog summaries for catalogs with the specified catalog_ids.
    # @param request The request object with the catalog identifiers to search for.
    # @return Returns the HTTP response of the GET request with catalog summaries.
    def find_by_ids(request)
      get ProductCatalog.find_by_ids(request.catalog_ids)
    end

    # This operation retrieves a list of product catalog summaries for a given product ID.
    # @param request The request object with the product identifier to search matching catalogs for.
    # @return Returns the HTTP response of the GET request with catalog summaries.
    def find_product_catalogs_for_product(request)
      get ProductCatalog.find_product_catalogs_for_product(request.product_id)
    end

    # This operation retrieves the version for a specified product catalog identifier.
    # @param catalog_id The identifier of the catalog.
    # @return Returns the HTTP response of the GET request with the version number of the specified catalog.
    def get_version(catalog_id)
      get ProductCatalog.get_version catalog_id
    end
  end
end
