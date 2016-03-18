  
module BlackhawkApi 
  class ProductCatalogVersionResponse < BaseResponse
    attr_reader :version
    
    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end
    
    protected
    def parse object
      @version = object.response
    end
  end
end