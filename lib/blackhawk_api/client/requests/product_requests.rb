require 'blackhawk_api/client/requests/base_request'

module BlackhawkApi

  class FindProductByKeywordRequest < PaginatedRequest
    attr_reader :keyword, :exact_match, :case_sensitive
    
    def initialize(keyword, exact_match = true, case_sensitive = true)
      @keyword = keyword
      @exact_match = exact_match
      @case_sensitive = case_sensitive
    end
  end
  
  class FindProductByProvisioningTypeRequest < PaginatedRequest
    attr_reader :provisioning_type
    
    def initialize(provisioning_type)      
      @provisioning_type = provisioning_type
    end
  end
  
  class FindProductByProductLineRequest < PaginatedRequest
    attr_reader :productline_id
    
    def initialize(productline_id)
      @productline_id = productline_id
    end
  end
  
  class FindProductsByIdsRequest < PaginatedRequest
    attr_reader :product_ids
    
    def initialize(ids)
      @product_ids = ids
    end
  end
  
  class FindProductByConfigurationRequest < PaginatedRequest
    attr_reader :configuration_id
    
    def initialize(configuration_id)
      @configuration_id = configuration_id 
    end
  end
  
  
  
  
  class FindProductLinesByBrandRequest < PaginatedRequest
    attr_reader :brand_id
    
    def initialize(brand_id)      
      @brand_id = brand_id
    end
  end
  
  class FindProductLinesByIdsRequest < PaginatedRequest
    attr_reader :productline_ids
    
    def initialize(productline_ids)      
      @productline_ids = productline_ids
    end
  end 
end