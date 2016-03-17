require "blackhawk_api/version"

module BlackhawkApi
  class BaseResponse
    attr_reader :total, :first, :maximum, :ascending
    
    def initialize(total, parameters)
      @total = total
      @first = parameters.first
      @maximum = parameters.maximum
      @ascending = parameters.ascending
    end 
  end
end