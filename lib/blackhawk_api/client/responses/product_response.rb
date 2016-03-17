require "blackhawk_api/version"
require "blackhawk_api/client/base"
require 'json'

module BlackhawkApi
  class ProductResponse
    attr_reader :total, :first, :maximum, :ascending
    
    def initialize(total, parameters)
      @total = total
      @first = parameters.first
      @maximum = parameters.maximum
      @ascending = parameters.ascending
    end 
  end
end