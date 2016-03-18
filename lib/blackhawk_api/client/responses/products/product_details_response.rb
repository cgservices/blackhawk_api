require "blackhawk_api/client/base"
require 'blackhawk_api/client/dto/product_details'

module BlackhawkApi
  class ProductDetailsResponse < BaseResponse
    attr_reader :details
    
    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end
    
    protected
    def parse object
      @details = ProductDetails.new(object.details)
    end
  end
end