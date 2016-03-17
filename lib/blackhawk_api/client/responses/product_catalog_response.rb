require "blackhawk_api/version"
require "blackhawk_api/client/base"
require 'json'

module BlackhawkApi
  
  class ProductCatalogResponse < BaseResponse
    def initialize(total, parameters)
      super(total, parameters)
    end
  end
end