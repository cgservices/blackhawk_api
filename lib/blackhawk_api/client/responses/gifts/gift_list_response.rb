require 'blackhawk_api/client/dto/gift_details'

module BlackhawkApi
  class GiftListResponse < BaseResponse
    attr_reader :total, :results
    
    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end
    
    protected
    def parse object
      @total = object.total
      @results = object.results.map { |v| GiftDetails.new(v) }
    end
  end
end