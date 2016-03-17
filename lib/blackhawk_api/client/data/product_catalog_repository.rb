require 'blackhawk_api/client/requests/base_request'
require 'blackhawk_api/client/client'
require 'json'

module BlackhawkApi
  class ProductCatalogRepository < Client
    # This operation queries all product catalog summaries.
    def all request
      get ProductCatalog.all
    end
    
    # This operation reads product catalog information based on a specified product catalog identifier.
    def find catalog_id
      get ProductCatalog.find catalog_id
    end
    
    # This operation queries product catalog summaries for a catalog by name.
    def find_by_name request
      get ProductCatalog.find_by_name(request.name)
    end
    
    # This operation queries product catalog summaries for catalogs with the specified catalog_ids.
    def find_by_ids request
      get ProductCatalog.find_by_ids(request.catalog_ids)
    end
    
    # This operation retrieves a list of product catalog summaries for a given product ID.
    def find_product_catalogs_for_product request
      get ProductCatalog.find_product_catalogs_for_product(request.product_id)
    end
    
    # This operation retrieves the version for a specified product catalog identifier.
    def get_version catalog_id
      get ProductCatalog.get_version catalog_id
    end
  end
end