module BlackhawkApi
  # Class to handle API request errors.
  class ApiErrorHandler
    # Inspects the result retrieved from the API call.
    # @param response The raw response from the API call.
    # @param result The parsed result object from the API call.
    # @raise ApiError instance with the result code and description message.
    def _inspect(response, result)
      return if response.code == 200
      
      if result.kind_of?(Array)
        error = ApiError.new(response.code, result.first.errorCode, result.first.message) 
      else
        error = ApiError.new(response.code, result.errorCode, result.message)
      end
      raise error
    end
  end
end
