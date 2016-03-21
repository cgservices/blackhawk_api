require 'blackhawk_api/client/dto/product_line_details'

module BlackhawkApi  
  class ProductLineDetailsResponse < BaseResponse
    attr_reader :information
    
    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end
    
    protected 
    def parse object
      @information = ProductLineDetails.new(object)
    end
  end
end