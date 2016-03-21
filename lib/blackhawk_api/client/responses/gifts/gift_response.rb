require 'blackhawk_api/client/dto/gift_details'
module BlackhawkApi
  class GiftDetailsResponse < BaseResponse
    attr_reader :information
    
    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end
    
    protected
    def parse object
      @information = GiftDetails.new(object)
    end
  end
end