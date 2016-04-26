module BlackhawkApi
  # Represents an error that has occurred in the BlackHawk API. 
  class ApiError < RuntimeError
    attr_reader :http_code,
                :error_code,
                :description

    # Initializes a new Error object.
    # @param code The HTTP STATUS code.
    # @param error The error that occurred.
    # @param description A description about the error that occurred.
    def initialize(code, error, description)
      @http_code = code
      @error_code = error
      @description = description
    end
  end

  # Class to handle API request errors.
  class ApiErrorHandler
    # Inspects the result retrieved from the API call.
    # @param response The raw response from the API call.
    # @param result The parsed result object from the API call.
    # @raise ApiError instance with the result code and description message.
    def _inspect(response, result)
      return if response.code == 200

      raise ApiError.new(response.code, result.errorCode, result.message)
    end
  end
end
