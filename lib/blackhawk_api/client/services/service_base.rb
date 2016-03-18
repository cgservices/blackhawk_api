require 'json'

module BlackhawkApi
  # Base class for application services.
  class BlackhawkService
    # Initializes a new ApplicationService.
    # @param error_handler An implementation for error handling for this service.
    def initialize(error_handler = nil)
      @handler = error_handler ||= ApiErrorHandler.new
    end
    
    protected
    def validate request
      return true
    end
    
    def inspected response
      return response if @handler.nil?
      
      result = JSON.parse(response.raw_body, object_class: OpenStruct)
      @handler._inspect(response, result)
      return [response, result]
    end
  end
end