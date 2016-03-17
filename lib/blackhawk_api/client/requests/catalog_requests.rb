require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi
  class GetCatalogVersionRequest < PaginatedRequest
    attr_reader :catalog_id
    
    def initialize(catalog_id, sort_key, page_index, page_size)
      super(sort_key, page_index, page_size)
      
      @catalog_id = catalog_id
    end
  end
  
  class GetAllCatalogsRequest < PaginatedRequest
    def initialize
    end
  end
  
  class FindCatalogsForProductRequest < PaginatedRequest
    attr_reader :product_id
    
    def initialize(product_id)      
      @product_id = product_id
    end
  end
  
  class FindCatalogsByIdsRequest < PaginatedRequest
    attr_reader :catalog_ids
    
    def initialize(catalog_ids)      
      @catalog_ids = catalog_ids
    end
  end
  
  class FindCatalogsByNameRequest < PaginatedRequest
    attr_reader :name
    
    def initialize(name)      
      @name = name
    end
  end
end
