module BlackhawkApi
  class AccountTransactionCorrelationResponse < BaseResponse
    attr_reader :correlation_id
    
    def initialize(http_response)
      super(http_response.code, http_response.headers, http_response.raw_body)
    end
    
    protected
    def parse(object)
      # TODO: Parse correlation id 
      @correlation_id = object
    end
  end
end