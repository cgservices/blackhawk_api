require 'blackhawk_api/version'

module BlackhawkApi
  # Represents an error that has occurred in the BlackHawk API request. 
  class ApiError < RuntimeError
    attr_reader :http_code
    attr_reader :error_code
    attr_reader :description
    
    # Initializes a new Error object
    def initialize(code, error, description)
      @http_code = code
      @error_code = error
      @description = description
    end
  end
  
  # Class to handle API request errors.
  class ApiErrorHandler
    # Inspects the result retrieved from the API call.
    def inspect response, result
      return if response.code == 200
      
      raise ApiError.new(response.code, result.errorCode, result.message)
    end
  end
end