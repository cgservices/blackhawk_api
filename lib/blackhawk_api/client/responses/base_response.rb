require "blackhawk_api/version"

module BlackhawkApi
  class BaseResponse
    attr_reader :code, :headers, :body
    
    def initialize(code, headers, body)
      @code = code
      @headers = headers
      @body = body
      
      parse JSON.parse(body, object_class: OpenStruct)
    end
    
    protected
    def parse (parsed_object) end
  end

  class PaginatedResponse < BaseResponse
    attr_reader :total, :first, :maximum, :ascending
    
    def initialize(code, headers, body, total, parameters)
      super(code, headers, body)
      
      @total = total
      @first = parameters.first
      @maximum = parameters.maximum
      @ascending = parameters.ascending
    end 
  end
end