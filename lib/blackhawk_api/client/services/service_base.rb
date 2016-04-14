require 'json'

module BlackhawkApi
  # Base class for application services.
  class BlackhawkService
    # Initializes a new ApplicationService.
    # @param error_handler An implementation for error handling for this service.
    def initialize(error_handler = nil)
      @handler = error_handler || ApiErrorHandler.new
    end

    protected

    def validate(request)
      validator_class_name = request.class.name.split('::').last + 'Validator'
      validator ||= Object.const_get('BlackhawkApi')
                          .const_get(validator_class_name).new rescue nil

      return validator.validate!(request) unless validator.nil?
      true # Skip validation if no validator is found.
    end

    def inspected(response)
      return response if @handler.nil?

      result = JSON.parse(response.raw_body, object_class: OpenStruct)
      @handler._inspect(response, result)
      [response, result]
    end

    def perform(request, &_block)
      return unless validate request

      response = yield
      inspected response
    end
  end
end
